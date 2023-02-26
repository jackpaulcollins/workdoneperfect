import { Controller } from '@hotwired/stimulus';
import Tribute from 'tributejs';
import Trix from 'trix';

export default class extends Controller {
  static targets = ['field'];

  connect() {
    this.editor = this.fieldTarget.editor;
    this.initializeTribute();
  }

  initializeTribute() {
    this.tribute = new Tribute({
      allowSpaces: true,
      lookup: 'name',
      values: this.fetchUsers,
      menuShowMinLength: 1,
    });
    this.tribute.attach(this.fieldTarget);
    this.fieldTarget.addEventListener('tribute-replaced', this.replaced);
    this.tribute.range.pasteHtml = this._pasteHtml.bind(this);
  }

  disconnect() {
    this.tribute.detach(this.fieldTarget);
  }

  fetchUsers(text, callback) {
    fetch(`/users/mentions.json?query=${text}`)
      .then((response) => response.json())
      .then((users) => callback(users))
      .catch((error) => callback([]));
  }

  replaced(e) {
    const mention = e.detail.item.original;
    const attachment = new Trix.Attachment({
      content: mention.content,
      sgid: mention.sgid,
    });
    this.editor.insertAttachment(attachment);
    this.editor.insertString(' ');
  }

  _pasteHtml(html, startPos, endPos) {
    const range = this.editor.getSelectedRange();
    const position = range[0];
    const length = endPos - startPos;

    this.editor.setSelectedRange([position - length, position]);
    this.editor.deleteInDirection('backward');
  }
}

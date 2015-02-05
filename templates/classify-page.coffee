translate = require 'zooniverse/lib/translate'

module.exports = -> """
  <div class="readymade-classification-interface">
    <div class="readymade-no-more-subjects-message" style="display: none;">
      <p>Looks like we\'re temporarily out of data to classify. Please check back later!</p>
      <p>In the meantime, <a href="https://www.zooniverse.org/">check out some other projects in the Zooniverse!</a></p>
    </div>
    <div class="readymade-subject-viewer-container"></div>
    <div class="fixed-panel">
      <div class="readymade-decision-tree-container"></div>
      <div class="readymade-summary-container" style="display: none;"></div>
      <div class="drawing-controls">
        <label class="readymade-has-clickable">
          <input type="checkbox" name="favorite" />
          <span class="readymade-clickable">
            #{translate 'readymade.favoriteIcon'}
            #{translate 'readymade.favoriteIconChecked'}
            <span>#{translate 'readymade.favorite'}</span>
          </span>
        </label>

        <button name="restart-tutorial">
          <span class="readymade-clickable">
            #{translate 'readymade.tutorialIcon'}
            <span>#{translate 'readymade.restartTutorial'}</span>
          </span>
        </button>
      </div>
    </div>
  </div>
  <div class="readymade-field-guide-container"></div>
"""

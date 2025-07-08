# Chiyori's nvim configs !

## The ultimate chiyori's nvim spell book!

Some of these are not native to nvim. 
Some of these are configured by kickstart. 

### Insert:
- i : Insert at start of char
- I : Insert at the begining of the line
- [number] i [char]: Insert [number] of [char]
- a : Insert at end of char
- A : Insert at the end of the line
- o : Create a new line below and insert

### Jumping:
- 0 : Start of the line.
- $ : End of the line.
- shift+{ : Jump to previous empty line.
- shift+} : Jump to next empty line.
- w : Next start of the word.
- e : Next end of the word.
- b : Last start of the word.
- gg : Start of the file.
- G : End of the file.
- :[number] : Jump to line.
- [number] j : Jump up [number] line.
- [number] k : Jump down [number] line.
- [ or ] + d : Jump to the next/prev diagnostic/error.
- *: Cycle through the current word your cursor at, or previous searched word.

When using f, you could use ; to jump to the next char or , to the previous

- f [char]: Jump to the next [char]
- [number] f [char] : Jump to the next [number] of [char]
- [number] F [char] : Jump to the previous [number] of [char]
- m+/-[number] : Move current line +/- [number] of line
- % : Jump between closure on the current cursor : ex) from ( to )
- grr: Show list of reference. 
- grd: Jump to definition on current cursor.
- ctrl-o: Jump back after jumping to definition.

### Copy/Paste:
- y : (yank) Copy
- Y : Yank the entire line
- d : Cut 
- D : Cut the entire line
- p : (put) Paste

Also works with number in front
- ex) 5dd : delete 5 lines below
- ex) 2p : Paste it twice

### Undo/Redo:
- Undo : u
- redo : Ctrl+r

### Selection:
- v : Toggle visual selector mode.

3-part selection commands  
v = Select, c = Change, d = Delete/Cut  
i = Include, a = Around  
w = Word, or [anything]  

examples:
- viw : To select the current word where the cursor at.
- ciw : Select and change the current word where the cursor at.
- diw : Select and delete the current wordf where the cursor at.
- ya" : Select everything inside " and include the " and yank it.

Also if you use W instead of w, it still select the entire word including symbols.

examples:
target word = someVariable.nestedChild;
cursor at = someVariable
- diw: Will select someVariable
- diW: Will select someVariable.nestedChild;

Other than visual selector, you could peform operations by specifiying line:  
examples: 
- :30,35y : yank line 30 to 35
- :25,50d : cut line 25 to 50
- :40,55sort : Sort line 40 to 55
- c-v : Block selector, which is different than visual selector, could use to insert and delete multi-line

### Search/Filter:
- / : Trigger filter -> Enter to confirm
- n : Next result
- N : Previous match
- :%s/old/new/g  : Find and replace entire file
- :%s/old/new/gc  : Find and replace with confirmation
- <leader>sl : Telescope item look up
- <leader>sf : Telescope search file
- <leader>sg : Telescope search global (fuzzy)

### Indentation:
- Tab : Right Indent
- Shift+Tab : Left indent
- J : Take the next line and merge into current line (SUCK A LINE UP)
- =G : Auto indent everything below.

### Folding:
- zc: Fold on cursor.
- zo: Open fold on cursor.
- za: Toggle fold on cursor.
- zM: Close all.
- zR: Open all.

### Multi line operation:
- Ctrl+v, I, insert, esc : Insert text on multiple line

### Marking : 
0~9, A~Z are gobal marking that exist on the entire project. 
a~z are local marking that only exist on current buffer.
- m[a-z] : Set mark to current line.
- '[a-z] : Jump to mark [a-z].
- delm! | delm A-Z : Delete all marks.

### Buffer (Opened files):
- <leader>b : Open list of buffer (By.Telescope plugin)
- bn : Next buffer
- bp : Previous buffer
- bd : Close buffer
- ls : Show list of buffer
- buffer [number] : Jump to buffer

### Windows
- Ctrl+w : Toggle window tools
- Ctrl+w+v : Split windows vertically
- Ctrl+w+q : Close current window
- Ctrl+cmd+Arrowkey : resize window

# Other
- long press space : search buffer
- If you have live-server installed:
- :!live-server . : To open live server
- K: Trigger tooltip
- :MarkdownPreview: Live preview mark down. 

### Conversion
Select any word (like using visual selector), then  
- u : Convert all word into lower case
- U : Convert all word into upper case

### Neo-tree:
- a : Create file or directory
- d : Delete file or directory
- r : Rename file or directory

### Code Companion
- Buffer Chat:
- :CodeCompanion Toggle (use #buffer to target the current buffer)

inline support:
- 1) Move the cursor/highlight content
- 2) :CodeCompanion <Question here>

### Telescope
- <leader>sf : Find files 
- <leader>sg : Find global

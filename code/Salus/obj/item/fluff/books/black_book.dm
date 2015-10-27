/* For Helldog217 */

/obj/item/weapon/book/black_book
	name = "Damian's Black Book"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	author = "Damian"
	title = "Damian's Black Book"


	dat = "<B>Player notes</B><HR>"

/obj/item/weapon/book/black_book/New()

	var/savefile/bookfile = new("data/book_files/damian.sav")


	bookfile["author"] >> author
	bookfile["title"] >> title


/obj/item/weapon/book/black_book/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen))
		if(unique)
			user << "These pages don't seem to take the ink well. Looks like you can't modify it."
			return
		var/choice = input("What would you like to change?") in list("Title", "Contents", "Author", "Add Text", "Cancel")
		switch(choice)
			if("Title")
				var/newtitle = reject_bad_text(stripped_input(usr, "Write a new title:"))
				if(!newtitle)
					usr << "The title is invalid."
					return
				else
					src.name = newtitle
					src.title = newtitle
			if("Contents")
				var/content = strip_html(input(usr, "Write your book's contents (HTML NOT allowed):"),8192) as message|null
				if(!content)
					usr << "The content is invalid."
					return
				else
					src.dat += content

			if("Add Text")
				var/savefile/bookfile = new("data/book_files/damian.sav")


			if("Author")
				var/newauthor = stripped_input(usr, "Write the author's name:")
				if(!newauthor)
					usr << "The name is invalid."
					return
				else
					src.author = newauthor
			else
				return
# CharacterKill
###### _This script allows the specified users to delete a character from the database, thus performing a "Character Kill" for roleplay servers. Requires ESX._

## How does it work

Valid players will be able to use _CK_ command as well as _CKStatus_ command.
If _FullCharDelete_ is set to **true**, it'll delete everything about the player in the database.
If _FullCharDelete_ is set to **false**, it'll delete only that player's identity, thus being the name, lastname, DOB, height and skin.
In _Config.lua_ you have to add your rockstar license, add as many as you want.

You **must** change the databases values in _server.cfg_ to your own databases, you can add new tables or delete existing ones, just copy and paste this code inside _deleteIdentityFromDatabase_:

```            
MySQL.Async.execute('DELETE FROM TABLENAME WHERE IDE = @ide',{
                ['@ide'] = identifier
            })
```

Change _TABLENAME_ with the name of the table you want to delete it from.
Change _IDE_ with the name of the column the identifier is stored into, for example "owner" or "id", look it up in your table structure.

#### Commands
- CK [NUMBER]: performs a CK on that player ID, this player must be online at the time. He'll be kicked out of the server with a message configurable in locale.
- CKStatus: Shows the user whether it is set to completely erase the player or just its identity.

### How to install it?

Just as any other FiveM resource;
- Download it as .zip: 
    - If you do so, unzip it anywhere inside a folder, then copy that folder into your _resources_ folder and add _start NAME_ to your server.cfg file, where _NAME_ is the name of the folder you unzipped everything in.
- Clone it to your server: 
    - If you choose this option is because you understand how this works.

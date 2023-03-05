# Virtual Private Server Deploy 1.0.0
This is a custom script for deploying on a Virtual Private Server. You are encouraged to modify it by adding your own commands. This is running Laravel and therefore the folder structure is tuned to that scenario. PR welcomed.

## Steps to Deploy 

- ssh into server. 
- clone this repo
- make it executable: " chmod u+x server.sh "
- run: " bash -x server.sh "
- It would prompt you to specify the Github or Gitlab repo to clone. (Just cut and paste the repo).
- It should now prompt you to specify the folder name: eg "my_new_website" which corresponds to "/var/www/html/public/my_new_website/". Basically where your website/Web Application files are stored.
- FFor Laravel, Specify your .env file


<!-- 
- Bullet point 3

Paragraph of text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tincidunt massa. Integer in mauris est. Aenean sit amet elit nec sapien fringilla eleifend. In hac habitasse platea dictumst. Nam vitae lorem a nisl dictum tincidunt.

### Another subsection

1. Numbered item 1
2. Numbered item 2
3. Numbered item 3

Paragraph of text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tincidunt massa. Integer in mauris est. Aenean sit amet elit nec sapien fringilla eleifend. In hac habitasse platea dictumst. Nam vitae lorem a nisl dictum tincidunt.

#### Sub-subsection

Paragraph of text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tincidunt massa. Integer in mauris est. Aenean sit amet elit nec sapien fringilla eleifend. In hac habitasse platea dictumst. Nam vitae lorem a nisl dictum tincidunt.

##### Sub-sub-subsection

Paragraph of text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tincidunt massa. Integer in mauris est. Aenean sit amet elit nec sapien fringilla eleifend. In hac habitasse platea dictumst. Nam vitae lorem a nisl dictum tincidunt. -->

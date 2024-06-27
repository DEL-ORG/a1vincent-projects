```sh
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@terraform" \
    -f ./azure-terraform
```
## Explanation
ssh-keygen: This is the command used to generate a new SSH key pair. SSH keys are used for secure access to servers without using passwords.

-m PEM: This option specifies the format of the key. PEM stands for Privacy-Enhanced Mail, which is a base64 encoded format with header and footer lines. It is a widely used format for keys and certificates. Using -m PEM ensures the key is in PEM format, which is compatible with many systems.

-t rsa: The -t option specifies the type of key to create. In this case, rsa stands for the RSA algorithm, which is a widely used public-key encryption technology.

-b 4096: The -b option sets the number of bits in the key. Here, 4096 bits are specified, which makes the key stronger and more secure. RSA keys can be of various lengths, and 4096 bits is considered to be very secure.

-C "azureuser@terraform": The -C option allows you to specify a comment that gets embedded in the key. This comment can help identify the key. In this case, "azureuser@terraform" is the comment, which likely indicates that this key will be used by the user azureuser in the context of Terraform, an infrastructure as code software tool.

-f ./azure-terraform: The -f option specifies the file name to save the key pair. Here, the base name azure-terraform is used, which means the private key will be saved as ./azure-terraform and the public key will be saved as ./azure-terraform.pub.

Putting it all together, this command generates a new RSA SSH key pair with a length of 4096 bits, in PEM format, with a comment indicating its use for azureuser@terraform, and saves the keys to the specified files (azure-terraform for the private key and azure-terraform.pub for the public key).

## to connect using ssh 
ssh-keygen -f "/c/Users/evfom/.ssh/known_hosts" -R "ip"
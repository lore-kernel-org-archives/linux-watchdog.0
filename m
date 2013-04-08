Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.2]:41654 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934313Ab3DHH4g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Apr 2013 03:56:36 -0400
Message-ID: <51627669.1070900@digi.com>
Date: Mon, 8 Apr 2013 09:48:57 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] watchdog: core: don't try to stop device if not running
References: <515EF748.6060504@digi.com> <20130405183450.GA29835@roeck-us.net>
In-Reply-To: <20130405183450.GA29835@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 04/05/2013 08:34 PM, Guenter Roeck wrote:
> On Fri, Apr 05, 2013 at 06:09:44PM +0200, Hector Palacios wrote:
>> A watchdog device may be stopped from userspace using WDIOC_SETOPTIONS
>> ioctl and flag WDIOS_DISABLECARD. If the device is closed after this
>> operation, watchdog_release() is called and status bits checked for
>> stopping it. Besides, if the device has not been unregistered a critic=
al
>> message "watchdog did not stop!" is printed, although the ioctl may ha=
ve
>> successfully stopped it already.
>>
>> Without the patch a user application sample code like this will succes=
sfully
>> stop the watchdog, but the kernel will output the message
>> "watchdog did not stop!":
>>
>> 	wd_fd =3D open("/dev/watchdog", O_RDWR);
>>
>> 	flags =3D WDIOS_DISABLECARD;
>> 	ioctl(wd_fd, WDIOC_SETOPTIONS, &flags);
>>
>> 	close(wd_fd);
>>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>
> How about the following patch instead ?
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdo=
g_dev.c
> index 08b48bb..9775e8d 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -469,7 +469,9 @@ static int watchdog_release(struct inode *inode, st=
ruct file *file)
>   	 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
>   	 * watchdog_stop will fail.
>   	 */
> -	if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
> +	if (!test_bit(WDOG_ACTIVE, &wdd->status))
> +		err =3D 0;
> +	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
>   	    !(wdd->info->options & WDIOF_MAGICCLOSE))
>   		err =3D watchdog_stop(wdd);
>
> Much less invasive and the result is the same.

I like the simplicity but it is kind of inverted logic to initially defin=
e err =3D=20
-EBUSY only to turn it to zero later, so I'm rebuilding your approach lik=
e this:

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
index ef8edec..a4163cd 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -463,16 +463,19 @@ out:
  static int watchdog_release(struct inode *inode, struct file *file)
  {
         struct watchdog_device *wdd =3D file->private_data;
-       int err =3D -EBUSY;
+       int err =3D 0;

         /*
          * We only stop the watchdog if we received the magic character
          * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
          * watchdog_stop will fail.
          */
-       if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
-           !(wdd->info->options & WDIOF_MAGICCLOSE))
+       if (test_bit(WDOG_ACTIVE, &wdd->status))
+               err =3D -EBUSY;
+       else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
+           !(wdd->info->options & WDIOF_MAGICCLOSE)) {
                 err =3D watchdog_stop(wdd);
+       }

         /* If the watchdog was not stopped, send a keepalive ping */


which makes the code more readable.
Thanks,
--=20
H=E9ctor Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48488 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756739AbcJPPjC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Oct 2016 11:39:02 -0400
Subject: Re: [PATCH] watchdog: Remove misleading word "legacy" for
 /dev/watchdog
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        linux-watchdog@vger.kernel.org
References: <alpine.LFD.2.20.1610160645550.19356@localhost.localdomain>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <43d28f1d-ddd8-924a-5a9c-80d7fc56de58@roeck-us.net>
Date: Sun, 16 Oct 2016 08:38:50 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1610160645550.19356@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/16/2016 03:49 AM, Robert P. J. Day wrote:
> The word "legacy" should not be used for the special file
> /dev/watchdog, as that file is still essential for watchdog
> operations.
>

NAK. The non-legacy name is /dev/watchdog0.

Guenter

> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   i expressed my reservations about use of the word "legacy" here:
>
> https://lists.kernelnewbies.org/pipermail/kernelnewbies/2016-October/017054.html
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 32930a0..0cc5ab8 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -891,7 +891,7 @@ static struct miscdevice watchdog_miscdev = {
>   *	@wdd: watchdog device
>   *	@devno: character device number
>   *
> - *	Register a watchdog character device including handling the legacy
> + *	Register a watchdog character device including handling the
>   *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
>   *	thus we set it up like that.
>   */
> @@ -968,7 +968,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   *	watchdog_cdev_unregister: unregister watchdog character device
>   *	@watchdog: watchdog device
>   *
> - *	Unregister watchdog character device and if needed the legacy
> + *	Unregister watchdog character device and if needed the
>   *	/dev/watchdog device.
>   */
>
> @@ -1002,7 +1002,7 @@ static struct class watchdog_class = {
>   *	watchdog_dev_register: register a watchdog device
>   *	@wdd: watchdog device
>   *
> - *	Register a watchdog device including handling the legacy
> + *	Register a watchdog device including handling the
>   *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
>   *	thus we set it up like that.
>   */
> @@ -1040,7 +1040,7 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>   *	watchdog_dev_unregister: unregister a watchdog device
>   *	@watchdog: watchdog device
>   *
> - *	Unregister watchdog device and if needed the legacy
> + *	Unregister watchdog device and if needed the
>   *	/dev/watchdog device.
>   */
>
>


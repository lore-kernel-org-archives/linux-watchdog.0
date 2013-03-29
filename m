Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54736 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab3C2J52 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Mar 2013 05:57:28 -0400
Received: by mail-ob0-f174.google.com with SMTP id 16so287818obc.5
        for <linux-watchdog@vger.kernel.org>; Fri, 29 Mar 2013 02:57:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1361969118-19081-1-git-send-email-fabio.porcedda@telit.com>
References: <1361969118-19081-1-git-send-email-fabio.porcedda@telit.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Fri, 29 Mar 2013 10:57:07 +0100
Message-ID: <CAHkwnC-Y3=PPx185dyxicg1yor8xxeq6L92DwNG9LPRQB=4-fg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: core: fix some whitespace and comment to
 improve coding style
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 27, 2013 at 1:45 PM, Fabio Porcedda
<fabio.porcedda@telit.com> wrote:
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
>
> - Fix alignement of some function declarations
> - Remove some superfluous empty lines
> - Fix a comment because of_get_timeout_sec function does not exist
>
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/watchdog_core.c |  4 ++--
>  drivers/watchdog/watchdog_dev.c  | 27 ++++++---------------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 05d18b4..3bc4ec0 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -36,7 +36,7 @@
>  #include <linux/init.h>                /* For __init/__exit/... */
>  #include <linux/idr.h>         /* For ida_* macros */
>  #include <linux/err.h>         /* For IS_ERR macros */
> -#include <linux/of.h>          /* For of_get_timeout_sec */
> +#include <linux/of.h>          /* For of_* functions */
>
>  #include "watchdog_core.h"     /* For watchdog_dev_register/... */
>
> @@ -70,7 +70,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>   * A zero is returned on success and -EINVAL for failure.
>   */
>  int watchdog_init_timeout(struct watchdog_device *wdd,
> -                               unsigned int timeout_parm, struct device *dev)
> +                         unsigned int timeout_parm, struct device *dev)
>  {
>         unsigned int t = 0;
>         int ret = 0;
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 08b48bb..cfbc806 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -58,7 +58,6 @@ static struct watchdog_device *old_wdd;
>   *     exactly that.
>   *     We only ping when the watchdog device is running.
>   */
> -
>  static int watchdog_ping(struct watchdog_device *wddev)
>  {
>         int err = 0;
> @@ -91,7 +90,6 @@ out_ping:
>   *     This function returns zero on success or a negative errno code for
>   *     failure.
>   */
> -
>  static int watchdog_start(struct watchdog_device *wddev)
>  {
>         int err = 0;
> @@ -124,7 +122,6 @@ out_start:
>   *     failure.
>   *     If the 'nowayout' feature was set, the watchdog cannot be stopped.
>   */
> -
>  static int watchdog_stop(struct watchdog_device *wddev)
>  {
>         int err = 0;
> @@ -161,9 +158,8 @@ out_stop:
>   *
>   *     Get the watchdog's status flags.
>   */
> -
>  static int watchdog_get_status(struct watchdog_device *wddev,
> -                                                       unsigned int *status)
> +                              unsigned int *status)
>  {
>         int err = 0;
>
> @@ -190,9 +186,8 @@ out_status:
>   *     @wddev: the watchdog device to set the timeout for
>   *     @timeout: timeout to set in seconds
>   */
> -
>  static int watchdog_set_timeout(struct watchdog_device *wddev,
> -                                                       unsigned int timeout)
> +                               unsigned int timeout)
>  {
>         int err;
>
> @@ -224,9 +219,8 @@ out_timeout:
>   *
>   *     Get the time before a watchdog will reboot (if not pinged).
>   */
> -
>  static int watchdog_get_timeleft(struct watchdog_device *wddev,
> -                                                       unsigned int *timeleft)
> +                                unsigned int *timeleft)
>  {
>         int err = 0;
>
> @@ -254,9 +248,8 @@ out_timeleft:
>   *     @cmd: watchdog command
>   *     @arg: argument pointer
>   */
> -
>  static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
> -                                                       unsigned long arg)
> +                            unsigned long arg)
>  {
>         int err;
>
> @@ -288,9 +281,8 @@ out_ioctl:
>   *     Writing the magic 'V' sequence allows the next close to turn
>   *     off the watchdog (if 'nowayout' is not set).
>   */
> -
>  static ssize_t watchdog_write(struct file *file, const char __user *data,
> -                                               size_t len, loff_t *ppos)
> +                             size_t len, loff_t *ppos)
>  {
>         struct watchdog_device *wdd = file->private_data;
>         size_t i;
> @@ -328,9 +320,8 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
>   *     The watchdog API defines a common set of functions for all watchdogs
>   *     according to their available features.
>   */
> -
>  static long watchdog_ioctl(struct file *file, unsigned int cmd,
> -                                                       unsigned long arg)
> +                          unsigned long arg)
>  {
>         struct watchdog_device *wdd = file->private_data;
>         void __user *argp = (void __user *)arg;
> @@ -407,7 +398,6 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>   *     Watch out: the /dev/watchdog device is single open, so we make sure
>   *     it can only be opened once.
>   */
> -
>  static int watchdog_open(struct inode *inode, struct file *file)
>  {
>         int err = -EBUSY;
> @@ -458,7 +448,6 @@ out:
>   *     stop the watchdog when we have received the magic char (and nowayout
>   *     was not set), else the watchdog will keep running.
>   */
> -
>  static int watchdog_release(struct inode *inode, struct file *file)
>  {
>         struct watchdog_device *wdd = file->private_data;
> @@ -517,7 +506,6 @@ static struct miscdevice watchdog_miscdev = {
>   *     /dev/watchdog node. /dev/watchdog is actually a miscdevice and
>   *     thus we set it up like that.
>   */
> -
>  int watchdog_dev_register(struct watchdog_device *watchdog)
>  {
>         int err, devno;
> @@ -560,7 +548,6 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
>   *
>   *     Unregister the watchdog and if needed the legacy /dev/watchdog device.
>   */
> -
>  int watchdog_dev_unregister(struct watchdog_device *watchdog)
>  {
>         mutex_lock(&watchdog->lock);
> @@ -580,7 +567,6 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
>   *
>   *     Allocate a range of chardev nodes to use for watchdog devices
>   */
> -
>  int __init watchdog_dev_init(void)
>  {
>         int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
> @@ -594,7 +580,6 @@ int __init watchdog_dev_init(void)
>   *
>   *     Release the range of chardev nodes used for watchdog devices
>   */
> -
>  void __exit watchdog_dev_exit(void)
>  {
>         unregister_chrdev_region(watchdog_devt, MAX_DOGS);
> --
> 1.8.1.1
>

ping

Best regards
--
Fabio Porcedda

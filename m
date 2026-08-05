Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295C22D7A9
	for <linux-watchdog@vger.kernel.org>; Wed,  5 Aug 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926468; cv=none; b=idzrLyRoTJaZGLZ1rH0mxYyvcPweXJNj2vz8ucdxMoOA9nMMH6jbh8jIW4Crtvc0I94l5yVagmA2CCwA+jCn530zcpLGy1zbvKVzG0sgM/nZpRVHa3CCoV4/TUu3lhJezSo33wg0W4/YObHybws2If3N6YmhjOWgXZZsUDaKnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926468; c=relaxed/simple;
	bh=+UZ3e7OfIkPYt9iQUMgYqhqmi3mqOie+2TX6/D4z9Eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFPcCd23k44iKlbYjDpbx8AC2FLArtg9cb07Go/oE2V8LKZaJPSfzQYBXEIjYIY3VZhR/5l779XHn8DjFVIb/mPC5WEZlKk/91gSuLh6Q635r8Ff1FDzPH32OxsxDF+0dtUVSHbIjpkZWRKTzjNKI99lOpoMdxnHAFoHyza0l+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V92kID2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V92kID2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88B21F000E9;
	Wed,  5 Aug 2026 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785926466;
	bh=qVjrHfDSylGlvb3vcCeZPpv/5+M2ubKpXw9OLQwWBag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V92kID2IFh/sAdsMOnq69y3bAK4SAHer77ojINqJHLEdPYZVbCNawDSjvJHTTIkSw
	 Pt1Lj44i9SjciOSFW+aaAkjeFdzE+NRtnTCqL4Ey8FN3QD9SGsnS4WrJW9qW7T1ki5
	 NGewutlmCORkUpxASGyTSZ3qPCCMEc6rObJlWxWyZTSFYbZClNitDryUOG7y7kd9u/
	 QfTjXSPW+c/Cl0qB15lbzb2nPQOCxDOI7rpaKHQUxQXkHMd+9qsmPFCs+Yz1BNacWO
	 NjdCWlifs2565GTG8B4ng1QrPSXIedxZGduH59Ed5t+7cINXcS+vstuaD5ycOOoyl4
	 /fKdpQsRXS7pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: keep device alive for open files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qing Ming" <a0yami@mailbox.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260805102907.5354-1-a0yami@mailbox.org>
References: <20260805102907.5354-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 10:41:06 +0000
Message-Id: <20260805104106.A88B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `usb_pcwd_probe()` fails, the global `cards_found` counter is n=
ot decremented, permanently preventing any subsequent devices from being pr=
obed.
- [High] `usb_pcwd_temperature_read` copies exactly 1 byte from a 32-bit `i=
nt` to userspace, causing incorrect temperature readings on both little-end=
ian and big-endian architectures.
- [High] Error checking in `usb_pcwd_get_temperature` and `usb_pcwd_get_tim=
eleft` ignores a return value of `0` from `usb_pcwd_send_command`, falsely =
treating timeouts as success.
- [High] Concurrent `open()` and `disconnect()` can leave the hardware watc=
hdog armed after the driver unbinds.
- [High] Unconditional busy-wait loop executes even if the USB control mess=
age fails, causing a 250ms kernel thread stall.
--

--- Patch [1]: [PATCH] watchdog: pcwd_usb: keep device alive for open files=
 ---
commit 832556793ce76f6a3d61309293d57fe82b13b7f2
Author: Qing Ming <a0yami@mailbox.org>
Subject: watchdog: pcwd_usb: keep device alive for open files

This patch addresses a use-after-free issue when reading temperature files
across USB disconnects. It stores the device object in file->private_data
and manages its lifecycle via a kref reference count. The disconnect logic
is updated to serialize teardown and quiesce the device properly.

Link: Cc: stable@vger.kernel.org

> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index d7c18c990649a..9ef7a4a472846 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
[ ... ]
> @@ -258,6 +270,8 @@ static int usb_pcwd_send_command(struct usb_pcwd_priv=
ate *usb_pcwd,
> =20
>  	kfree(buf);
> =20
> +out_unlock:
> +	mutex_unlock(&usb_pcwd->mtx);
>  	return got_response;
>  }

[Severity: High]
This is a pre-existing issue, but does this function stall a kernel thread =
for
250ms if the control message fails?

Looking at usb_pcwd_send_command(), if usb_control_msg() fails (e.g., due t=
o a
device unplug), the code proceeds directly into a polling loop:

for (count =3D 0; (count < USB_COMMAND_TIMEOUT) && (!got_response); count++=
) {
        mdelay(1);
        ...
}

Since got_response will remain 0, wouldn't this busy-wait for the full time=
out
(250 iterations of mdelay), causing unnecessary CPU spinning and delaying
other USB processing?

> @@ -327,8 +341,11 @@ static int usb_pcwd_get_temperature(struct usb_pcwd_=
private *usb_pcwd,
>  {
>  	unsigned char msb =3D 0x00;
>  	unsigned char lsb =3D 0x00;
> +	int ret;
> =20
> -	usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
> +	ret =3D usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does checking ret < 0
miss the error case where usb_pcwd_send_command() returns 0?

usb_pcwd_send_command() returns 0 on timeout or memory allocation failure.
If a command times out, wouldn't this function proceed to calculate the res=
ult
using uninitialized or zero-initialized local buffers for msb and lsb,
reporting fake values to userspace instead of propagating the error?

> @@ -344,10 +361,14 @@ static int usb_pcwd_get_timeleft(struct usb_pcwd_pr=
ivate *usb_pcwd,
>  {
>  	unsigned char msb =3D 0x00;
>  	unsigned char lsb =3D 0x00;
> +	int ret;
> =20
>  	/* Read the time that's left before rebooting */
>  	/* Note: if the board is not yet armed then we will read 0xFFFF */
> -	usb_pcwd_send_command(usb_pcwd, CMD_READ_WATCHDOG_TIMEOUT, &msb, &lsb);
> +	ret =3D usb_pcwd_send_command(usb_pcwd, CMD_READ_WATCHDOG_TIMEOUT,
> +				    &msb, &lsb);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
This is a pre-existing issue, but similar to the temperature function above,
does checking ret < 0 fail to catch the 0 return value on timeout?

If the timeout occurs, it looks like it will calculate time_left using
the zero-initialized msb and lsb buffers.

[ ... ]
> @@ -476,29 +504,55 @@ static long usb_pcwd_ioctl(struct file *file, unsig=
ned int cmd,
> =20
>  static int usb_pcwd_open(struct inode *inode, struct file *file)
>  {
> +	struct usb_pcwd_private *usb_pcwd;
> +	int ret;
> +
> +	mutex_lock(&disconnect_mutex);
> +	usb_pcwd =3D usb_pcwd_device;
> +	if (!usb_pcwd || !usb_pcwd->exists) {
> +		ret =3D -ENODEV;
> +		goto out_unlock;
> +	}
>  	/* /dev/watchdog can only be opened once */
> -	if (test_and_set_bit(0, &is_active))
> -		return -EBUSY;
> +	if (test_and_set_bit(0, &is_active)) {
> +		ret =3D -EBUSY;
> +		goto out_unlock;
> +	}
> +	kref_get(&usb_pcwd->kref);
> +	file->private_data =3D usb_pcwd;
> +	mutex_unlock(&disconnect_mutex);
> =20
>  	/* Activate */
> -	usb_pcwd_start(usb_pcwd_device);
> -	usb_pcwd_keepalive(usb_pcwd_device);
> -	return stream_open(inode, file);
> +	usb_pcwd_start(usb_pcwd);

[Severity: High]
This is a pre-existing issue, but can concurrent execution of usb_pcwd_open=
()
and usb_pcwd_disconnect() leave the hardware watchdog armed after the driver
unbinds?

If usb_pcwd_open() checks usb_pcwd->exists and then drops disconnect_mutex:

Thread 1 in usb_pcwd_open():
    mutex_unlock(&disconnect_mutex);

Could Thread 2 in usb_pcwd_disconnect() acquire the mutex, clear
usb_pcwd_device, drop the mutex, and execute usb_pcwd_stop() before setting
exists to 0?

Thread 2 in usb_pcwd_disconnect():
    usb_pcwd_stop(usb_pcwd);
    mutex_lock(&usb_pcwd->mtx);
    usb_pcwd->exists =3D 0;
    mutex_unlock(&usb_pcwd->mtx);

If Thread 1 then executes usb_pcwd_start(usb_pcwd) right after Thread 2
completes its stop, wouldn't the hardware watchdog remain armed without a
bound driver to ping it, resulting in an unintended reboot?

[ ... ]
> @@ -509,10 +563,13 @@ static int usb_pcwd_release(struct inode *inode, st=
ruct file *file)
>  static ssize_t usb_pcwd_temperature_read(struct file *file, char __user =
*data,
>  				size_t len, loff_t *ppos)
>  {
> +	struct usb_pcwd_private *usb_pcwd =3D file->private_data;
>  	int temperature;
> +	int ret;
> =20
> -	if (usb_pcwd_get_temperature(usb_pcwd_device, &temperature))
> -		return -EFAULT;
> +	ret =3D usb_pcwd_get_temperature(usb_pcwd, &temperature);
> +	if (ret)
> +		return ret;
> =20
>  	if (copy_to_user(data, &temperature, 1))
>  		return -EFAULT;

[Severity: High]
This isn't a bug introduced by this patch, but does copy_to_user() only copy
1 byte of the 4-byte int temperature variable to userspace?

On little-endian architectures, wouldn't this truncate any value over 255, =
and
on big-endian architectures, wouldn't it always copy the most significant b=
yte
which is 0?

[ ... ]
> @@ -747,12 +835,20 @@ static int usb_pcwd_probe(struct usb_interface *int=
erface,
>  	return 0;
> =20
>  err_out_misc_deregister:
> +	mutex_lock(&disconnect_mutex);
> +	if (usb_pcwd_device =3D=3D usb_pcwd)
> +		usb_pcwd_device =3D NULL;
> +	mutex_unlock(&disconnect_mutex);
> +	mutex_lock(&usb_pcwd->mtx);
> +	usb_pcwd->exists =3D 0;
> +	mutex_unlock(&usb_pcwd->mtx);
> +	usb_kill_urb(usb_pcwd->intr_urb);
>  	misc_deregister(&usb_pcwd_temperature_miscdev);
>  err_out_unregister_reboot:
>  	unregister_reboot_notifier(&usb_pcwd_notifier);
>  error:
>  	if (usb_pcwd)
> -		usb_pcwd_delete(usb_pcwd);
> +		kref_put(&usb_pcwd->kref, usb_pcwd_delete);
>  	usb_pcwd_device =3D NULL;
>  	return retval;
>  }

[Severity: High]
This is a pre-existing issue, but does the error path fail to decrement the
global cards_found counter?

In usb_pcwd_probe(), cards_found is incremented early on:

    cards_found++;
    if (cards_found > 1) {
        pr_err("This driver only supports 1 device\n");
        return -ENODEV;
    }

If the probe fails (e.g., due to out-of-memory or not being a HID device), =
it
jumps to the error path and returns without decrementing cards_found. Since
usb_pcwd_disconnect() won't be called for a failed probe, wouldn't this
permanently prevent any subsequent devices from being successfully probed
until the module is reloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805102907.5354=
-1-a0yami@mailbox.org?part=3D1

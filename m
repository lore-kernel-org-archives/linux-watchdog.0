Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35571 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab2EMMUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 May 2012 08:20:35 -0400
Received: by weyu7 with SMTP id u7so1237437wey.19
        for <linux-watchdog@vger.kernel.org>; Sun, 13 May 2012 05:20:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336730427-1664-4-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
	<1336730427-1664-4-git-send-email-hdegoede@redhat.com>
Date: Sun, 13 May 2012 15:20:34 +0300
Message-ID: <CA+i0qc6FEdFomBn6_HDGsXYiVQa0gtbELpkjNK6dqy5aoaoytA@mail.gmail.com>
Subject: Re: [PATCH 3/9] watchdog-kernel-api.txt: Document new watchdog_dev fields
From: Tomas Winkler <tomasw@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2012 at 1:00 PM, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> =C2=A0Documentation/watchdog/watchdog-kernel-api.txt | =C2=A0 11 ++++++=
++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documenta=
tion/watchdog/watchdog-kernel-api.txt
> index 227f6cd..03aa948 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -1,6 +1,6 @@
> =C2=A0The Linux WatchDog Timer Driver Core kernel API.
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Last reviewed: 16-Mar-2012
> +Last reviewed: 11-May-2012
>
> =C2=A0Wim Van Sebroeck <wim@iguana.be>
>
> @@ -46,6 +46,10 @@ struct watchdog_device {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int min_timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int max_timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *driver_data;
> + =C2=A0 =C2=A0 =C2=A0 int id;
> + =C2=A0 =C2=A0 =C2=A0 struct cdev cdev;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
> + =C2=A0 =C2=A0 =C2=A0 struct device *busdev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long status;
> =C2=A0};

I would split this patch into two according the original patches that
add the code to not complicate a possible rollback of an patch.

Thanks
Tomas
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

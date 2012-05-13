Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43784 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab2EMMPj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 May 2012 08:15:39 -0400
Received: by weyu7 with SMTP id u7so1235842wey.19
        for <linux-watchdog@vger.kernel.org>; Sun, 13 May 2012 05:15:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FAD40EE.90707@redhat.com>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk>
	<20120504123815.GS3074@spo001.leaseweb.com>
	<20120510192023.GA31117@spo001.leaseweb.com>
	<4FACC4C1.9040104@redhat.com>
	<20120511160218.GE3074@spo001.leaseweb.com>
	<4FAD40EE.90707@redhat.com>
Date: Sun, 13 May 2012 15:15:37 +0300
Message-ID: <CA+i0qc4RnDaUbzBk0RexG1o36H2kBmabetkEiW2ADEkCYgWyRw@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
From: Tomas Winkler <tomasw@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2012 at 7:40 PM, Hans de Goede <hdegoede@redhat.com> wrot=
e:
>
> Hi,
>
>
> On 05/11/2012 06:02 PM, Wim Van Sebroeck wrote:
>>
>> Hi Hans,
>>
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id !=3D 0)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;
>>>
>>>
>>>
>>> I believe the check above should be:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (id !=3D 0 =
|| ret !=3D -EBUSY)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ret;
>>>
>>> IOW we should not retry the registration if it failed for another rea=
son
>>> then the id already being taken by a legacy driver.
>>
>>
>> Than for readibility we should say:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(id =3D=3D=
 0&& =C2=A0ret =3D=3D -EBUSY))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret
>
>
> ACK.
>
> Regards,
>
> Hans
+ if (imajor(inode) =3D=3D MISC_MAJOR)
+               wdd =3D old_wdd;
+       else wdd =3D container_of(inode->i_cdev, struct watchdog_device, =
cdev);

You should break the line after 'else'

+       else
+          wdd =3D container_of(inode->i_cdev, struct watchdog_device, cd=
ev);

Thanks
Tomas
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64983 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab2ENRaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 13:30:03 -0400
Received: by qcro28 with SMTP id o28so3531820qcr.19
        for <linux-watchdog@vger.kernel.org>; Mon, 14 May 2012 10:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
	<20120514135209.GM3074@spo001.leaseweb.com>
	<5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com>
Date: Mon, 14 May 2012 20:30:02 +0300
Message-ID: <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 5:00 PM, Winkler, Tomas <tomas.winkler@intel.com>=
 wrote:
>> changes
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0with the comments that Hans made.
>> > V3: (by Tomas)
>> > =C2=A0 =C2=A0 1. Fix compilation error caused by missing include to
>> > watchdog_dev.h
>>
>> Is allready in linux-watchdog-next (see commit
>> 1761f6851b23e1cd61705c4c053decabb14f9092)
>
> Hmm =C2=A0didn't know that -next exists till now... I'll have a look.
> Thanks
> Tomas

I see you've add my changes into the patch and  rebased that tree,
usually  this is not preferable strategy for public git tree as it
creates conflicts.
Should we expect the -next tree to be rebased from time to time?

Thanks
Tomas
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

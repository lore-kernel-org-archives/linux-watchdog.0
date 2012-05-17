Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58504 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965781Ab2EQLac convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 07:30:32 -0400
Received: by qcro28 with SMTP id o28so1120365qcr.19
        for <linux-watchdog@vger.kernel.org>; Thu, 17 May 2012 04:30:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120517071906.GU3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
	<20120514135209.GM3074@spo001.leaseweb.com>
	<5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com>
	<CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com>
	<20120517071906.GU3074@spo001.leaseweb.com>
Date: Thu, 17 May 2012 14:30:31 +0300
Message-ID: <CA+i0qc7CjyMi6GSs8aaJH-=6bWAM6JMHngTz7n02ODVcGp-p5g@mail.gmail.com>
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

On Thu, May 17, 2012 at 10:19 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
> Hi Tomas,
>
> > I see you've add my changes into the patch and =C2=A0rebased that tre=
e,
> > usually =C2=A0this is not preferable strategy for public git tree as =
it
> > creates conflicts.
> > Should we expect the -next tree to be rebased from time to time?
>
> I try to avoid rebasing, but it's sometimes better to change new patche=
s
> (although sometimes it's better not to). So Yes a rebase is possible in
> linux-watchdog-next. (Which is according to the rules of linux-next).
>
Thanks for clarification.
BTW the patch is gone again from the tree.

Thanks
Tomas
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

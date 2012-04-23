Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60015 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab2DWLft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 07:35:49 -0400
Received: by wibhq7 with SMTP id hq7so2782406wib.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Apr 2012 04:35:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F9514AA.10403@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
	<7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
	<4F9514AA.10403@arm.com>
Date: Mon, 23 Apr 2012 17:05:48 +0530
Message-ID: <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
From: viresh kumar <viresh.linux@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Viresh Kumar <viresh.kumar@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2012 at 2:06 PM, Marc Zyngier <marc.zyngier@arm.com> wrot=
e:
> Irk! Have you actually tested this?

Yes. But with incorrect base address. I passed timers address by mistake.

> The DT binding indicates:
> - reg : Specify the base address and the size of the TWD watchdog
> =A0 =A0 =A0 =A0register window.
>
> while all the offsets in smp_twd.h are expressed in bytes from the TWD
> *timer* base. So you have to either fix these offsets (which breaks
> potential users of the non-DT version of the driver), or correct the
> base when using DT.

You are correct. Which one do you prefer:
- Change bindings to pass timers base address
- subtract 0x20 from base address for DT case
- something else.

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

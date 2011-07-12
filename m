Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:17860 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755648Ab1GLViO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Jul 2011 17:38:14 -0400
Message-ID: <4E1CBE5E.5090404@draigBrady.com>
Date: Tue, 12 Jul 2011 22:36:30 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/2] [RFC] watchdog reboot timeout
References: <20110706160744.4002.94920.stgit@bhelgaas.mtv.corp.google.com> <4E15B9FD.8080003@draigBrady.com> <CAErSpo5=TQm9SLM9dE2-Sm7ZLvaSXAZOorE1z9SK9kEh9CUbNQ@mail.gmail.com>
In-Reply-To: <CAErSpo5=TQm9SLM9dE2-Sm7ZLvaSXAZOorE1z9SK9kEh9CUbNQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 12/07/11 17:25, Bjorn Helgaas wrote:
> On Thu, Jul 7, 2011 at 7:51 AM, P=E1draig Brady <P@draigbrady.com> wrot=
e:
>> A related issue I noticed with iTCO_wdt is that something
>> else in the kernel disables the iTCO watchdog (which my BIOS had start=
ed).
>> This is undesirable for obvious reasons.
>=20
> This sounds related to iTCO, but unrelated to my patch.  Right?

Right, unrelated to your patch but it could affect you.
As the kernel comes up it may reinit the iTCO, disabling
the watchdog until the iTCO_wdt module is loaded and patted.

cheers,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

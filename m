Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:56317 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcGFJSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Jul 2016 05:18:41 -0400
Date: Wed, 6 Jul 2016 11:18:39 +0200
From: Stefan Christ <s.christ@phytec.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 0/6] Implement I2C restart handler
Message-ID: <20160706091838.GC7031@lws-christ>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <20160705145839.GA3641@tetsubishi>
MIME-Version: 1.0
In-Reply-To: <20160705145839.GA3641@tetsubishi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Tue, Jul 05, 2016 at 11:58:41PM +0900, Wolfram Sang wrote:
> Hi,
>=20
> > this is a request for feedback about a lockdep-warning-free I2C
> > restart_handler.  I would like to know whether someone had the prob=
lem already
> > and how the best and mainline friendliest solution looks like.
> > I have an embedded board with the PMIC chip DA9063 that is also use=
d as a
> > voltage regulator for DVFS. For a clean reboot/reset of the system =
I have to
> > set the bit nSHUTDOWN in the PMIC via I2C. The restart_handler call=
 chain
> > is of type
> >=20
> >     static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
> >=20
> > So any code running as a restart_handler cannot (should not) wait, =
for other
> > locks. When you use i2c_transfer/regmap you get lockdep warnings li=
ke [1].
>=20
> Yes, this problem has come up occasionally. And it is not only about
> sleeping. IRQs are disabled, too.
>=20
> My idea was to introduce master_xfer_irqless or similar to struct
> i2c_algorithm. I even discussed this shortly with Mark Brown how to
> interact with regmap; but this was too long ago, so I forgot what we
> agreed on :(

Great. I was looking for exactly this kind of feedback.

The term 'master_xfer_irqless' does not bring up anything on the intern=
et and I
didn't find anything on the list linux-i2c. Can you point me to the dis=
cussion,
so I can read it up and work on it?

> > Any comments?=20
>=20
> I just skimmed very lightly over the patchset. Yet, seeing an I2C cli=
ent
> messing directly with 'struct adapter' breaks so many abstractions, i=
t
> hits my instant-NACK nerve ;)

Yes, accessing the function directly is really ugly. I was thinking abo=
ut
augmenting the I2C interface and the regmap interface with 'sleep-free'=
 and
'irq-less' functions or flags, but this requires changing a lot of code=
=2E So I
was just taking this shortcut. For follow up patches I will rework this=
=2E

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Christ

> Thanks,
>=20
>    Wolfram
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

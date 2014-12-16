Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48388 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbaLPQfQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Dec 2014 11:35:16 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y0v5c-002oIR-SR
	for linux-watchdog@vger.kernel.org; Tue, 16 Dec 2014 16:35:16 +0000
Date: Tue, 16 Dec 2014 08:34:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Yingjoe Chen <yingjoe.chen@gmail.com>,
	Howard Chen <ibanezchen@gmail.com>, greta.zhang@mediatek.com,
	huang eddie <eddie.huang@mediatek.com>
Subject: Re: [PATCH v2 2/2] ARM: mediatek: dts: Add bindings for watchdog
Message-ID: <20141216163406.GB26966@roeck-us.net>
References: <1418395859-32209-1-git-send-email-matthias.bgg@gmail.com>
 <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
 <548C5F1F.8070804@roeck-us.net>
 <CABuKBe+=PaJ2BuhoGGwn8V20207QU3zzWb4UGgXzwwF-AvBEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABuKBe+=PaJ2BuhoGGwn8V20207QU3zzWb4UGgXzwwF-AvBEPw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 16, 2014 at 05:14:35PM +0100, Matthias Brugger wrote:
> 2014-12-13 16:45 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > On 12/12/2014 06:50 AM, Matthias Brugger wrote:
> >>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> ---
> >>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13
> >> +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> new file mode 100644
> >> index 0000000..af9eb5b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> @@ -0,0 +1,13 @@
> >> +Mediatek SoCs Watchdog timer
> >> +
> >> +Required properties:
> >> +
> >> +- compatible : should be "mediatek,mt6589-wdt"
> >
> >
> > "mediatek" is undefined as vendor prefix in the current upstream code.
> > Is this vendor prefix coming in from another patch set ?
> 
> Strange, should be in vendor-prefix.txt [1].
> Please double check.
> 
Sorry, I misunderstood the output from checkpatch.

Guenter

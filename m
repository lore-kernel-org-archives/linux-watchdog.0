Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40321 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbbAWRBv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 Jan 2015 12:01:51 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YEhcD-001k1R-Mw
	for linux-watchdog@vger.kernel.org; Fri, 23 Jan 2015 17:01:50 +0000
Message-ID: <54C27E4D.1010108@roeck-us.net>
Date: Fri, 23 Jan 2015 09:01:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>, wim@iguana.be,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	=?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
	Yingjoe Chen <yingjoe.chen@gmail.com>,
	Howard Chen <ibanezchen@gmail.com>, greta.zhang@mediatek.com,
	huang eddie <eddie.huang@mediatek.com>,
	Chen-Yu Tsai <wens@csie.org>, joe@perches.com
Subject: Re: [PATCH v5 0/2] ARM: mediatek: Add watchdog driver
References: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com> <CABuKBeKWU=wGuyT2u1Ndori1e8B7vAzFAmCafwLDPfAyLHkYBQ@mail.gmail.com>
In-Reply-To: <CABuKBeKWU=wGuyT2u1Ndori1e8B7vAzFAmCafwLDPfAyLHkYBQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/23/2015 06:20 AM, Matthias Brugger wrote:
> Hi all,
>
> 2015-01-13 13:28 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
>> Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
>> binding. The driver also implements a restart handler to reboot the SoC.
>
> Any comments on this patch set?
>
I have it included in the set of patches that I am going to send to Wim,
hopefully this weekend.

Guenter


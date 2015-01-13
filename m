Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43186 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbAMMEC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Jan 2015 07:04:02 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YB0CX-001LeS-Gh
	for linux-watchdog@vger.kernel.org; Tue, 13 Jan 2015 12:04:01 +0000
Message-ID: <54B5098D.9030108@roeck-us.net>
Date: Tue, 13 Jan 2015 04:03:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	grant.likely@linaro.org
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, heiko@sntech.de,
	yingjoe.chen@gmail.com, ibanezchen@gmail.com,
	greta.zhang@mediatek.com, eddie.huang@mediatek.com, wens@csie.org,
	joe@perches.com
Subject: Re: [PATCH v4 1/2] watchdog: Add driver for Mediatek watchdog
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com> <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
In-Reply-To: <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/2015 07:34 AM, Matthias Brugger wrote:
> This patch adds a driver for the Mediatek SoC integrated
> watchdog. This driver supports watchdog and software reset
> for mt65xx and mt81xx SoCs.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Assuming you fix the missing newline, as pointed out by Joe:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33961 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbBWTdQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:33:16 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPykm-003dvd-As
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 19:33:16 +0000
Date: Mon, 23 Feb 2015 11:32:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mathieu Olivari <mathieu@codeaurora.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH 2/3] ARM: qcom: add description of KPSS WDT for IPQ8064
Message-ID: <20150223193227.GD26070@roeck-us.net>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
 <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 06:19:35PM -0800, Mathieu Olivari wrote:
> Add the watchdog related entries to the Krait Processor Sub-system
> (KPSS) timer IPQ8064 devicetree section. Also, add a fixed-clock
> description of SLEEP_CLK, which will do for now.
> 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

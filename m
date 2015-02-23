Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34078 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbBWTeK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:34:10 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPyld-003eMG-F4
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 19:34:09 +0000
Date: Mon, 23 Feb 2015 11:33:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mathieu Olivari <mathieu@codeaurora.org>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: msm: add watchdog entries to DT timer binding
 doc
Message-ID: <20150223193323.GE26070@roeck-us.net>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
 <1424485176-8348-4-git-send-email-mathieu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424485176-8348-4-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 06:19:36PM -0800, Mathieu Olivari wrote:
> The watchdog has been reworked to use the same DT node as the timer.
> This change is updating the device tree doc accordingly.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

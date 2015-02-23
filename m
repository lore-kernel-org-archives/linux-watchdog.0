Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37392 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbbBWTFV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:05:21 -0500
Message-ID: <54EB79EE.5000205@codeaurora.org>
Date: Mon, 23 Feb 2015 11:05:18 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Mathieu Olivari <mathieu@codeaurora.org>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com
CC: devicetree@vger.kernel.org, Josh Cartwright <joshc@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: qcom: add description of KPSS WDT for IPQ8064
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org> <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
In-Reply-To: <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/20/15 18:19, Mathieu Olivari wrote:
> Add the watchdog related entries to the Krait Processor Sub-system
> (KPSS) timer IPQ8064 devicetree section. Also, add a fixed-clock
> description of SLEEP_CLK, which will do for now.
>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project


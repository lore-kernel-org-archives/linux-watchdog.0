Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56927 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcCWWm2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2016 18:42:28 -0400
Date: Wed, 23 Mar 2016 15:42:26 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to
 BITE time
Message-ID: <20160323224226.GD18567@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/23, Matthew McClintock wrote:
> For certain parts and some versions of TZ, TZ will reset the chip
> when a BARK is triggered even though it was not configured here. So
> by default let's configure this BARK time as well.
> 

Why isn't TZ configuring the bark time to what it wants? I'm lost
why we have to do this for them.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

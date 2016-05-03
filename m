Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58034 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbcECMMI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 08:12:08 -0400
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, wim@iguana.be
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <57289594.3050801@codeaurora.org>
Date: Tue, 3 May 2016 07:12:04 -0500
MIME-Version: 1.0
In-Reply-To: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Pratyush Anand wrote:
> + * Note: This watchdog timer has two stages. If action is 0, first stage is
> + * determined by directly programming WCV and second by WOR. When first
> + * timeout is reached, WS0 is triggered and WCV is reloaded with value in
> + * WOR. WS0 interrupt will be ignored, then the second watch period starts;
> + * when second timeout is reached, then WS1 is triggered, system resets. WCV
> + * and WOR are programmed in such a way that total time corresponding to
> + * WCV+WOR becomes equivalent to user programmed "timeout".
> + * If action is 1, then we expect to call panic() at user programmed
> + * "timeout". Therefore, we program both first and second stage using WCV
> + * only.

So I'm not sure I understand how this works yet, but there was an 
earlier version of Fu's driver that did something similar.  It depended 
on being able to reprogram the hardware during the WS0 interrupt, and 
that was rejected by the community.

How is what you are doing different?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

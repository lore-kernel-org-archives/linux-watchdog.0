Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36084 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbcF1Fbg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 01:31:36 -0400
Subject: Re: [PATCH 0/3] qcom watchdog fixes
To: Thomas Pedersen <twp@codeaurora.org>,
	linux-watchdog@vger.kernel.org
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57720BB6.6010209@roeck-us.net>
Date: Mon, 27 Jun 2016 22:31:34 -0700
MIME-Version: 1.0
In-Reply-To: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/27/2016 04:26 PM, Thomas Pedersen wrote:
> Some boards (eg. qcom IPQ8064 based) Need these changes to avoid a spurious
> watchdog reset.
>
> Matthew McClintock (3):
>    watchdog: qcom: update device tree bindings
>    watchdog: qcom: add option for standalone watchdog not in timer block
>    watchdog: qcom: configure BARK time in addition to BITE time
>
>   .../devicetree/bindings/watchdog/qcom-wdt.txt      |  5 +-
>   drivers/watchdog/qcom-wdt.c                        | 78 ++++++++++++++++------
>   2 files changed, 59 insertions(+), 24 deletions(-)
>

General comment: If you don't plan to address the comments made to
the previous submission, please at least let the reviewers know
what you are doing and why. Also, a note indicating that this
is a resend would be helpful for those who did not see the original
series.

Thanks,
Guenter


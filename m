Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58075 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab2HQOHh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Aug 2012 10:07:37 -0400
Subject: Re: [v2 PATCH 1/1] booke/wdt: some ioctls do not return values properly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
Date: Fri, 17 Aug 2012 09:07:38 -0500
Cc: <B04825@freescale.com>, <linuxppc-dev@ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4EB00FE4-6A50-47DB-8BAB-3437489DC489@kernel.crashing.org>
References: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Aug 6, 2012, at 8:59 PM, Tiejun Chen wrote:

> Fix some booke wdt ioctls return value error.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
> drivers/watchdog/booke_wdt.c |    7 +++----
> 1 files changed, 3 insertions(+), 4 deletions(-)

applied to merge

- k

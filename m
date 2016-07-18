Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59221 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcGRRqD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jul 2016 13:46:03 -0400
Subject: Re: [PATCH] Documentation: Move samples from doc to samples/
To: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>, corbet@lwn.net,
	sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, arnd@arndb.de,
	nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org
References: <1468863402-1670-1-git-send-email-maheshkhanwalkar@gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <578D15D0.7020006@codeaurora.org>
Date: Mon, 18 Jul 2016 12:45:52 -0500
MIME-Version: 1.0
In-Reply-To: <1468863402-1670-1-git-send-email-maheshkhanwalkar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Mahesh Khanwalkar wrote:
>   samples/watchdog/Makefile                          |    3 +
>   samples/watchdog/watchdog-simple.c                 |   24 +
>   samples/watchdog/watchdog-test.c                   |   98 ++

Acked-by: Timur Tabi <timur@codeaurora.org>

However, watchdog-test.c has been updated in watchdog-next, so this 
patch won't apply.  You might want to use -M when creating this patch.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

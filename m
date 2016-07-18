Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35009 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcGRSjg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jul 2016 14:39:36 -0400
Subject: Re: [PATCH v2] Documentation: Move samples from doc to samples/
To: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>, corbet@lwn.net,
	sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
	tglx@linutronix.de, clemens@ladisch.de, wim@iguana.be,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	dasaratharaman.chandramouli@intel.com, arnd@arndb.de,
	nab@linux-iscsi.org, hans.verkuil@cisco.com,
	mchehab@osg.samsung.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linux-watchdog@vger.kernel.org
References: <578D15D0.7020006 () codeaurora ! org>
 <1468866787-4094-1-git-send-email-maheshkhanwalkar@gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <578D2264.6060205@codeaurora.org>
Date: Mon, 18 Jul 2016 13:39:32 -0500
MIME-Version: 1.0
In-Reply-To: <1468866787-4094-1-git-send-email-maheshkhanwalkar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Mahesh Khanwalkar wrote:
>   Documentation/mic/mpssd/micctrl                    | 173 ------------------
>   Documentation/mic/mpssd/mpss                       | 200 ---------------------

...

> +++ b/samples/mpssd/.gitignore
> @@ -0,0 +1,3 @@
> +mpssd
> +mpss
> +micctrl

I think this is wrong.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

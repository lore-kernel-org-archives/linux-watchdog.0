Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23521 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbcEYH4N (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 03:56:13 -0400
Message-ID: <57455A8B.1090807@intel.com>
Date: Wed, 25 May 2016 15:55:55 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Darren Hart <dvhart@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, qipeng.zha@intel.com
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com> <1463541972-19758-3-git-send-email-jonathan.yong@intel.com> <573BE985.1000306@roeck-us.net> <573BF421.2020503@intel.com> <573C7E0C.7050304@roeck-us.net> <20160524201316.GA5857@f23x64.localdomain>
In-Reply-To: <20160524201316.GA5857@f23x64.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/25/2016 04:13, Darren Hart wrote:
>
> The history of this driver is for Apollo Lake, so the question is if there exist
> v3 and v5 APL products, or if we only need to concern ourselves with v5 in the
> upstream driver.
>
> Especially given the "I don't know if this is the right way" in the cover
> letter, I will need an Acked-by at the very least from Qipeng.
>

Hi Qipeng,

Do you know the history behind drivers/platform/x86/intel_pmc_ipc.c? 
Were the specs based on earlier prototypes?


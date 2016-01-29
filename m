Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:16400 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbcA2PNg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Jan 2016 10:13:36 -0500
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
To: Wim Coekaerts <wim.coekaerts@oracle.com>, wim@iguana.be,
	linux@roeck-us.net
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Message-ID: <56AB816B.6030900@oracle.com>
Date: Fri, 29 Jan 2016 18:12:43 +0300
MIME-Version: 1.0
In-Reply-To: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 01/29/2016 12:46 AM, Wim Coekaerts wrote:
<cut>
> +static const struct watchdog_info sun4v_wdt_ident = {
> +	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +	.identity =	"sun4v hypervisor watchdog",
> +	.firmware_version = 0,
> +};

In accordance to watchdog_ioctl() in drivers/watchdog/watchdog_dev.c 
WDIOF_KEEPALIVEPING may be needed here as to enable the support of 
WDIOC_KEEPALIVE ioctl.

Correct? So maybe add it then?

Thanks.

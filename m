Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50875 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcA2XGe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Jan 2016 18:06:34 -0500
Subject: Re: [PATCH v7] Add sun4v_wdt watchdog driver
To: Wim Coekaerts <wim.coekaerts@oracle.com>, wim@iguana.be
References: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com>
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56ABF078.1070807@roeck-us.net>
Date: Fri, 29 Jan 2016 15:06:32 -0800
MIME-Version: 1.0
In-Reply-To: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/29/2016 09:39 AM, Wim Coekaerts wrote:
> This driver adds sparc hypervisor watchdog support. The default
> timeout is 60 seconds and the range is between 1 and
> 31536000 seconds. Both watchdog-resolution and
> watchdog-max-timeout MD properties settings are supported.
>
> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


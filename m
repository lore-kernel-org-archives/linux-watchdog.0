Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49062 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab2F0HE7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Jun 2012 03:04:59 -0400
Received: by bkcji2 with SMTP id ji2so630158bkc.19
        for <linux-watchdog@vger.kernel.org>; Wed, 27 Jun 2012 00:04:58 -0700 (PDT)
Message-ID: <4FEAB096.30103@monstr.eu>
Date: Wed, 27 Jun 2012 09:04:54 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: xilinx: Read clock frequency directly from
 DT node
References: <1340261140-10166-1-git-send-email-monstr@monstr.eu> <20120626191023.GI735@spo001.leaseweb.com>
In-Reply-To: <20120626191023.GI735@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/26/2012 09:10 PM, Wim Van Sebroeck wrote:
> Hi Michal,
>
>> Do not use clock-frequency property from parent node.
>> Use it from watchdog node.
>>
>> Signed-off-by: Michal Simek<monstr@monstr.eu>
>
> Added to linux-watchdog-next.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian

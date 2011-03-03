Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39664 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab1CCL5h (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2011 06:57:37 -0500
Message-ID: <4D6F827B.8040902@openwrt.org>
Date: Thu, 03 Mar 2011 12:58:51 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@mvista.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 05/10] MIPS: lantiq: add watchdog support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-6-git-send-email-blogic@openwrt.org> <4D6F7F1C.5040001@mvista.com>
In-Reply-To: <4D6F7F1C.5040001@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


>> +    /* write the first paswword magic */
>                               ^
>    You still didn't fix the typo here. :-)
>

Hi,

grml... changed it in the wrong folder :) i'll add it for the V4

thanks,
John

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:50544 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab1C3Jk1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2011 05:40:27 -0400
Message-ID: <4D92FAE6.1000407@openwrt.org>
Date: Wed, 30 Mar 2011 11:41:58 +0200
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org> <1301470076-17279-6-git-send-email-blogic@openwrt.org> <20110330093618.GH3974@infomag.iguana.be>
In-Reply-To: <20110330093618.GH3974@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

>> * add __init to probe function
>>     
> What were the changes for V5?
>
>   

v5 was related to irq handling in the mips specific code. the wdt did
not have changes between v4 and v5

thanks for the comments, i will fold them into the next series

John

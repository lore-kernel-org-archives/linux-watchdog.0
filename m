Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:36938 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1DDJXA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2011 05:23:00 -0400
Message-ID: <4D998E4C.3060708@openwrt.org>
Date: Mon, 04 Apr 2011 11:24:28 +0200
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 05/10] MIPS: lantiq: add watchdog support
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org> <1301470076-17279-6-git-send-email-blogic@openwrt.org> <20110330093618.GH3974@infomag.iguana.be>
In-Reply-To: <20110330093618.GH3974@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

some questions inline
>> +ltq_wdt_disable(void)
>> +{
>> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
>> +	ltq_wdt_ok_to_close = 0;
>> +#endif
>> +	/* write the first password magic */
>> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>> +	/* write the second password magic with no config
>> +	 * this turns the watchdog off
>> +	 */
>> +	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
>> +}
>>     
> Don't like this ifdef/ifndef stuff. The nowayout things can be done in the /dev/watchdog handling.
>
>   

Sorry i am not sure what you mean by "can be done in the /dev/watchdog
handling". could you be so kind and elaborate.

looking at some of the other drivers, there seem to be 2 strategies for
this.
1) using the #ifdef
2) using a module parameter

do you mean the later ?
> Please add the code to make sure that /dev/watchdog can be opened once.
>
>   

Do you mean "only" once ?

thanks for the clarification,
John


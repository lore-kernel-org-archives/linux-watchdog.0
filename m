Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:38750 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbbDTHLI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Apr 2015 03:11:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 20 Apr 2015 09:11:02 +0200
From: <harald@ccbib.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: <rtc-linux@googlegroups.com>, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <20150419153743.GA4353@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org> <20150417093023.GF29796@piout.net> <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net> <20150419153743.GA4353@piout.net>
Message-ID: <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexandre,

On Sun, 19 Apr 2015 17:37:43 +0200, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
>> >  - use syscon instead of passing callbacks to the watchdog driver
>> 
>> I will put looking into this onto my todo list, but I'm not familiar
>> with syscon yet and it is not obvious to me how to port the rtc driver
>> to syscon without breaking devicetree backwards compatibility. So I'd
>> like to defer this for later unless somebody gives me some guidance.
>> 
> 
> As the rtc driver is the one instantiating the watchdog driver, there is
> no reason why the DT ABI would be broken. You simply have to create
> the syscon in the RTC driver and then pass it to the watchdog driver,
> the same way it is done with the callbacks.

Ok, this is less invasive than what I have been thinking. This makes
sense. 
 
> I can have a look at doing it as I have some i.mx28 platforms.

If you can point me to a driver that is a good reference for your model,
then I can do this myself. Otherwise I'd prefer if you wrote the code.
I can do the testing though, if this helps.

Thanks,
Harald

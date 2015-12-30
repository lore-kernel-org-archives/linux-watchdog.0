Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53823 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754176AbbL3Jo4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 04:44:56 -0500
Date: Wed, 30 Dec 2015 10:44:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151230104452.0baeef09@free-electrons.com>
In-Reply-To: <20151229172848.GA14047@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
	<20151228152710.GA31482@spo001.leaseweb.nl>
	<20151228215709.GA30595@roeck-us.net>
	<20151228225427.GA2018@spo001.leaseweb.nl>
	<5681C2FE.7070100@mentor.com>
	<20151229071732.GA6292@spo001.leaseweb.nl>
	<20151229160411.GB30405@roeck-us.net>
	<20151229173705.1596cf1d@free-electrons.com>
	<20151229172848.GA14047@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

On Tue, 29 Dec 2015 09:28:48 -0800, Guenter Roeck wrote:

> Probem with SBSA and pretimeout is two-fold. First, it adds a quite a bit of
> complexity to the driver, second, it adds a lot of risk to the driver.
> Reason is that this is not one specific watchdog, but a watchdog implementation
> based on a standard which, in my opinion, is less than well thought out
> and leaves a lot of ambiguity when it comes to implementation details.

I agree that calling the SBSA watchdog specification a "specification"
is a strong word. At least in the version I have, it's 4-5 pages of
somewhat random thoughts on what a standardized watchdog could look
like, but not a very well-defined specification that guarantees that
all implementations will behave in the same way.

> The more functionality is used, the higher the risk that some implementation
> won't work.

Maybe we should enforce that all users of the driver use two Device
Tree compatible strings:

	compatible = "<vendor>,sbsa-gwdt", "arm,sbsa-gwdt";

So that the SBSA watchdog driver can implement vendor specific quirks
if needed. Though it is true that the HW has some identification
registers that should allow to differentiate between the implementation.

> I think we should stick with the basic implemementation and not support
> pretimeout at all with the SBSA driver. If the maximum timeout is insufficient,
> there are two options: Use the soft-timeout handled by the watchdog core,
> which will hopefully make it for 4.6, or live with it. 

For now, I'm personally fine with a SBSA driver that does not support
the pretimeout. Is anyone working on submitting something like this ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

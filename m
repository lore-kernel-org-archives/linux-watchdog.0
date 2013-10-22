Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:37422 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab3JVLCs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 07:02:48 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so7638760wes.8
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Oct 2013 04:02:47 -0700 (PDT)
Date: Tue, 22 Oct 2013 12:02:42 +0100
From: Jamie Iles <jamie@jamieiles.com>
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"dinguyen@altera.com" <dinguyen@altera.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [RESEND PATCHv2] watchdog: dw: Enable OF support for DW watchdog
 timer.
Message-ID: <20131022110242.GA7560@maple>
References: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
 <20131021110532.GA8144@kartoffel>
 <5265C9B0.2060003@roeck-us.net>
 <20131022103936.GA5511@kartoffel>
 <52665A1E.5020700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52665A1E.5020700@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 22, 2013 at 05:57:34AM -0500, Dinh Nguyen wrote:
> On 10/22/13 5:39 AM, Mark Rutland wrote:
> >Does the device have any interrupts, even if they're unused?
> Yes, the device does have an interrupt. Should I add it as an
> optional property?

iirc the interrupt feature is part of the IP configuration so not all 
instantiations will have the interrupt, so this should be an optional 
property.

Jamie

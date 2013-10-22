Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47344 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3JVRHq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 13:07:46 -0400
Date: Tue, 22 Oct 2013 10:07:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCHv6] watchdog: dw: Enable OF support for DW watchdog timer
Message-ID: <20131022170738.GA1699@roeck-us.net>
References: <1382461152-22891-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382461152-22891-1-git-send-email-dinguyen@altera.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 22, 2013 at 11:59:12AM -0500, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I'll also add the patch to the watchdog-next branch of my repository
at kernel.org.

Thanks,
Guenter

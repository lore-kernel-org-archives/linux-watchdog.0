Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpnchicago.adeneo-embedded.us ([65.182.180.190]:17181 "EHLO
	mxadeneo.adeneo-embedded.us" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755006AbbFKURv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 16:17:51 -0400
Date: Thu, 11 Jun 2015 13:17:35 -0700
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] watchdog_core: Add watchdog registration
 deferral mechanism
Message-ID: <20150611131735.525d65685225ea7e4a9d100b@adeneo-embedded.us>
In-Reply-To: <5577CDD9.9080501@roeck-us.net>
References: <1433868903-20033-1-git-send-email-jtheou@adeneo-embedded.us>
	<5577CDD9.9080501@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

Thanks a lot for your help and valuable feedbacks during this process

JB
On Tue, 9 Jun 2015 22:40:41 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 06/09/2015 09:55 AM, Jean-Baptiste Theou wrote:
> > Currently, watchdog subsystem require the misc subsystem to
> > register a watchdog. This may not be the case in case of an
> > early registration of a watchdog, which can be required when
> > the watchdog cannot be disabled.
> >
> > This patch introduces a deferral mechanism to remove this requirement.
> >
> > Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> > ---
> 
> Now you have a couple of unnecessary continuation lines ;-)
> 
> Anyway, I think this is good enough.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks,
> Guenter
> 


-- 
Jean-Baptiste Theou <jtheou@adeneo-embedded.us>

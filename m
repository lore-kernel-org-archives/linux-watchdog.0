Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26613 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754337AbbLTLyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 20 Dec 2015 06:54:47 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 4/7] watchdog: mei_wdt: add status debugfs entry
Date: Sun, 20 Dec 2015 11:54:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B540EE9EC@hasmsx108.ger.corp.intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-5-git-send-email-tomas.winkler@intel.com>
 <56743795.6090700@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B540EE5A6@hasmsx108.ger.corp.intel.com>
 <56768591.6060000@roeck-us.net>
In-Reply-To: <56768591.6060000@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



> >>> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> >>> +static const char *mei_wdt_state_str(enum mei_wdt_state state)
> >>> +{
> >>> +	switch (state) {
> >>> +	case MEI_WDT_IDLE: return "IDLE";
> >>> +	case MEI_WDT_START: return "START";
> >>> +	case MEI_WDT_RUNNING: return "RUNNING";
> >>> +	case MEI_WDT_STOPPING: return "STOPPING";
> >>> +	default: return "unknown";
> >>
> >> Doesn't this cause checkpatch warnings ?
> > It doesn't and also checkpatch.pl  is just a help tool.
> 
> I should have said "Doesn't this violate the single-statement-per-line"
> coding style rule, but I guess then you'd argue that "case xxx:" is not
> a statement.

I believe it is reasonably readable , but I don't have a strong feeling about it, if you do I can change it.

Tomas 


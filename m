Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43062 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbbAOOtG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 09:49:06 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YBljO-000xbG-Qj
	for linux-watchdog@vger.kernel.org; Thu, 15 Jan 2015 14:49:06 +0000
Message-ID: <54B7D35F.5010907@roeck-us.net>
Date: Thu, 15 Jan 2015 06:49:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
CC: Darren Hart <dvhart@infradead.org>,
	"'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com> <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com> <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org> <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com> <54AF6288.6040305@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com> <20150114181657.GB13907@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075D41C0@hasmsx107.ger.corp.intel.com>
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075D41C0@hasmsx107.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/15/2015 05:27 AM, Muller, Francois-nicolas wrote:
> TCO driver is anyway auto-loaded by mfd driver lpc_ich as a sub-function of it.
>
> The aim of my patch is only to add warning interrupt support in TCO driver.
> For this it need the GPE number which is exposed by Bios in acpi tables.
> So the patch registers also the TCO driver as an acpi driver to be able to retrieve this value.
>
> The acpi code part is only required by the interrupt handling support, not needed for the loading of the driver itself (already done by lpc_ich).
>
> In this context I don't see the point of dissociating the driver part from the loading, unless the loading would need to be reverted later.
>

Ok, makes sense.

Regarding the patch itself, I'll leave it up to Wim to decide what to do.
Personally I dislike the notion of panicing as response to a watchdog timeout.

Guenter


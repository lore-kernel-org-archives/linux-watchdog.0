Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:36302 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1CCQgQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2011 11:36:16 -0500
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 5/10] Generic Watchdog Timer Driver
Date: Thu, 3 Mar 2011 17:36:13 +0100
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20110223204330.GA7417@infomag.iguana.be> <20110303103814.GA3790@infomag.iguana.be> <20110303125317.GA23770@sirena.org.uk>
In-Reply-To: <20110303125317.GA23770@sirena.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103031736.14560.alexander.stein@systec-electronic.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 03 March 2011, 13:53:19 Mark Brown wrote:
> On Thu, Mar 03, 2011 at 11:38:14AM +0100, Wim Van Sebroeck wrote:
> 
> Reflowed into 80 columns.
> 
> > 2) Is there a real need for having 500ms or 1500ms? why would 1 or 2
> > seconds not be OK? (which are allready small timeouts for userspace
> > anyway...)
> 
> Yes, in embedded cases.  There it's much easier to have good control
> over userspace such that you can meet the scheduling requirements.

Embedded devices are also the target why I'm requesting this.

Regards,
Alexander

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34022 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1CCMxU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2011 07:53:20 -0500
Date: Thu, 3 Mar 2011 12:53:19 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 5/10] Generic Watchdog Timer Driver
Message-ID: <20110303125317.GA23770@sirena.org.uk>
References: <20110223204330.GA7417@infomag.iguana.be> <201102240921.02967.alexander.stein@systec-electronic.com> <20110303103814.GA3790@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110303103814.GA3790@infomag.iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 03, 2011 at 11:38:14AM +0100, Wim Van Sebroeck wrote:

Reflowed into 80 columns.

> 2) Is there a real need for having 500ms or 1500ms? why would 1 or 2
> seconds not be OK? (which are allready small timeouts for userspace
> anyway...)

Yes, in embedded cases.  There it's much easier to have good control
over userspace such that you can meet the scheduling requirements.

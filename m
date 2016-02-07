Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54642 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbcBGGL6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 7 Feb 2016 01:11:58 -0500
Date: Sat, 6 Feb 2016 22:11:57 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v4 0/7] mei: create proper iAMT watchdog driver
Message-ID: <20160207061157.GA21817@kroah.com>
References: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 08, 2016 at 12:49:20AM +0200, Tomas Winkler wrote:
> Instead of integrating the iAMT watchdog within the mei core driver
> we will create a watchdog device on the mei client bus and
> create a proper watchdog driver for it.
> 

I applied the first 4 patches here, please fix up the rest and resend.

thanks,

greg k-h

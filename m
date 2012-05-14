Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:41430 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751966Ab2ENNf1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 09:35:27 -0400
Date: Mon, 14 May 2012 15:35:19 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomasw@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
Message-ID: <20120514133519.GJ3074@spo001.leaseweb.com>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com> <20120510192023.GA31117@spo001.leaseweb.com> <4FACC4C1.9040104@redhat.com> <20120511160218.GE3074@spo001.leaseweb.com> <4FAD40EE.90707@redhat.com> <CA+i0qc4RnDaUbzBk0RexG1o36H2kBmabetkEiW2ADEkCYgWyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i0qc4RnDaUbzBk0RexG1o36H2kBmabetkEiW2ADEkCYgWyRw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

> + if (imajor(inode) == MISC_MAJOR)
> +               wdd = old_wdd;
> +       else wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);
> 
> You should break the line after 'else'
> 
> +       else
> +          wdd = container_of(inode->i_cdev, struct watchdog_device, cdev);

Will change this.

Kind regards,
Wim.


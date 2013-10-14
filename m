Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41143 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3JNQex (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Oct 2013 12:34:53 -0400
Date: Mon, 14 Oct 2013 09:34:52 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: pcwd_usb: Use allocated buffer for
 usb_control_msg
Message-ID: <20131014163452.GA11637@kroah.com>
References: <1381768174-15395-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381768174-15395-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 14, 2013 at 09:29:34AM -0700, Guenter Roeck wrote:
> usb_control_msg() must use a dma-capable buffer.
> 
> This fixes the following error reported by smatch:
> 
> drivers/watchdog/pcwd_usb.c:257 usb_pcwd_send_command() error: doing dma on the
> stack (buf)
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

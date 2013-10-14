Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55400 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab3JNPrm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Oct 2013 11:47:42 -0400
Message-ID: <525C1218.7060901@roeck-us.net>
Date: Mon, 14 Oct 2013 08:47:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: linux-usb <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: usb_control_msg and non-dma buffers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

I am getting the following smatch error in drivers/watchdog/pcwd_usb.c:

drivers/watchdog/pcwd_usb.c:257 usb_pcwd_send_command() error: doing dma on the stack (buf)

This is from a call to usb_control_msg().

Is this a false positive or a real problem that needs to be fixed ?

Thanks,
Guenter

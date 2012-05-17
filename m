Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65278 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369Ab2EQI7m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 04:59:42 -0400
MIME-Version: 1.0
In-Reply-To: <20120517084721.GV3074@spo001.leaseweb.com>
References: <1337019122-17300-1-git-send-email-devendra.aaru@gmail.com>
	<20120517084721.GV3074@spo001.leaseweb.com>
Date: Thu, 17 May 2012 14:29:41 +0530
Message-ID: <CAHdPZaN21ZuZTc0gJSb7QQ0LLq6JCeW2CApZmdMWkSggf2yegg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/watchdog: close the fd when cmdline arg given
From: "devendra.aaru" <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Landley <rob@landley.net>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wim,

On Thu, May 17, 2012 at 2:17 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Devendra,
>
>> in the watchdog test code, the ioctl is performed on the watchdog device
>> and just doing exit(0) so we leak a filedescripor.
>>
>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
>
> Patch added to linux-watchdog-next.
>
> Kind regards,
> Wim.
>

Thanks for taking the patch.

Actually we have a while (1) loop when ever user does ./watchdog-test,
and if ctrl + c is done, we wont close the socket.
i will send the patch sooner to fix this on top this patch.

Thanks,
Devendra.

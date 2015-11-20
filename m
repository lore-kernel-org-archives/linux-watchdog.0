Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:52844 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934659AbbKTChT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 21:37:19 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: add support for Sigma Designs SMP86xx/SMP87xx
References: <1447970945-9382-1-git-send-email-mans@mansr.com>
	<564E851A.2070205@roeck-us.net>
Date: Fri, 20 Nov 2015 02:37:10 +0000
In-Reply-To: <564E851A.2070205@roeck-us.net> (Guenter Roeck's message of "Thu,
	19 Nov 2015 18:27:38 -0800")
Message-ID: <yw1xk2pde6qx.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 11/19/2015 02:09 PM, Mans Rullgard wrote:
>> This adds support for the Sigma Designs SMP86xx/SMP87xx family built-in
>> watchdog.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Did you send the bindings document to some other mailing list (only) ?
> I see "PATCH 2/2" in some of your submissions, but I seem to be missing
> patch 1/2.

Blame scripts/get_maintaintainer.pl for that.  Anyway, here it is:
http://article.gmane.org/gmane.linux.drivers.devicetree/144423

-- 
Måns Rullgård
mans@mansr.com

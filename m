Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36385 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbbDBBmW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Apr 2015 21:42:22 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YdU9F-000lBD-9J
	for linux-watchdog@vger.kernel.org; Thu, 02 Apr 2015 01:42:21 +0000
Message-ID: <551C9E71.9010305@roeck-us.net>
Date: Wed, 01 Apr 2015 18:42:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: James Hogan <james.hogan@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH V2 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1427910196-28568-1-git-send-email-abrestic@chromium.org> <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
In-Reply-To: <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/01/2015 03:22 PM, James Hogan wrote:
> Hi Andrew,
>
> On Wed, Apr 01, 2015 at 10:43:14AM -0700, Andrew Bresticker wrote:
>> Since the heartbeat is statically initialized to its default value,
>> watchdog_init_timeout() will never look in the device-tree for a
>> timeout-sec value.  Instead of statically initializing heartbeat,
>> fall back to the default timeout value if watchdog_init_timeout()
>> fails.
>
> Whoops. Sorry about that. I wasn't aware that a timeout-sec value was
> expected. It isn't mentioned in the DT binding documentation for this
> device :-(.
>

Hi James,

This is a standard watchdog driver attribute. See
Documentation/watchdog/watchdog-kernel-api.txt.

[ Agreed, it would probably make sense to document that in the bindings. ]

Guenter


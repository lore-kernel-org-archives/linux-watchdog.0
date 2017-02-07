Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:60083 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbdBGOZ1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Feb 2017 09:25:27 -0500
Subject: Re: [PATCH v2] watchdog: softdog: make pretimeout support a compile
 option
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-watchdog@vger.kernel.org>
References: <20170207140329.31459-1-wsa+renesas@sang-engineering.com>
CC: <linux-renesas-soc@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <586b7403-6b2f-4a62-7d7d-3a7277119508@mentor.com>
Date: Tue, 7 Feb 2017 16:25:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170207140329.31459-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 02/07/2017 04:03 PM, Wolfram Sang wrote:
> It occurred to me that the panic pretimeout governor will stall the
> softdog, because it is purely software which simply breaks when the
> kernel panics. Testing governors with the softdog on the other hand is
> really useful, so make this feature a compile time option which nees to
> be enabled explicitly. This also removes the overhead if pretimeout
> support is not used because it will now be compiled away (saving ~10% on
> ARM32).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

the changes looks perfect,

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir

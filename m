Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:37273 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbcINNfr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Sep 2016 09:35:47 -0400
Date: Wed, 14 Sep 2016 07:35:44 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: richardcochran@gmail.com, wim@iguana.be, linux@roeck-us.net,
        nab@linux-iscsi.org, maheshkhanwalkar@gmail.com,
        timur@codeaurora.org, arnd@arndb.de, ghackmann@google.com,
        ben@decadent.org.uk, thuth@redhat.com,
        christopher.s.hall@intel.com, john.stultz@linaro.org,
        sergei.shtylyov@cogentembedded.com, mpe@ellerman.id.au,
        jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Move runnable code (tests) from Documentation to
 selftests
Message-ID: <20160914073544.578dc128@lwn.net>
In-Reply-To: <cover.1473795601.git.shuahkh@osg.samsung.com>
References: <cover.1473795601.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Sep 2016 14:18:39 -0600
Shuah Khan <shuahkh@osg.samsung.com> wrote:

> Move runnable code (tests) from Documentation to selftests and update
> Makefiles to work under selftests.

This all seems good to me.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

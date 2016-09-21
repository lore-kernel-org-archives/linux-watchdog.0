Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754413AbcIUVBF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 17:01:05 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Shuah Khan <shuahkh@osg.samsung.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "clemens@ladisch.de" <clemens@ladisch.de>,
        "wim@iguana.be" <wim@iguana.be>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ghackmann@google.com" <ghackmann@google.com>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        "maheshkhanwalkar@gmail.com" <maheshkhanwalkar@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] samples: move misc-devices/mei example code from
 Documentation
Date: Wed, 21 Sep 2016 21:00:54 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B542ECD57@hasmsx108.ger.corp.intel.com>
References: <cover.1474485474.git.shuahkh@osg.samsung.com>
 <5db171353261e2b20ebc78855057792a5a633699.1474485474.git.shuahkh@osg.samsung.com>
In-Reply-To: <5db171353261e2b20ebc78855057792a5a633699.1474485474.git.shuahkh@osg.samsung.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

>=20
> Move misc-devices/mei examples to samples/mei and remove it from
> Documentation Makefile. Delete misc-devices/Makefile.
>=20
> Create a new Makefile to build samples/mei. It can be built from top leve=
l
> directory or from mei directory:
>=20
> Run make -C samples/mei or cd samples/mei; make
>=20
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>


Acked-by: Tomas Winkler <tomas.winkler@intel.com>=20


> ---
>  Documentation/Makefile                           |   2 +-
>  Documentation/misc-devices/Makefile              |   1 -
>  Documentation/misc-devices/mei/.gitignore        |   1 -
>  Documentation/misc-devices/mei/Makefile          |   5 -
>  Documentation/misc-devices/mei/TODO              |   2 -
>  Documentation/misc-devices/mei/mei-amt-version.c | 479 -----------------=
---
> ---
>  MAINTAINERS                                      |   1 +
>  samples/mei/.gitignore                           |   1 +
>  samples/mei/Makefile                             |   9 +
>  samples/mei/TODO                                 |   2 +
>  samples/mei/mei-amt-version.c                    | 479
> +++++++++++++++++++++++
>  11 files changed, 493 insertions(+), 489 deletions(-)  delete mode 10064=
4
> Documentation/misc-devices/Makefile
>  delete mode 100644 Documentation/misc-devices/mei/.gitignore
>  delete mode 100644 Documentation/misc-devices/mei/Makefile
>  delete mode 100644 Documentation/misc-devices/mei/TODO
>  delete mode 100644 Documentation/misc-devices/mei/mei-amt-version.c
>  create mode 100644 samples/mei/.gitignore  create mode 100644
> samples/mei/Makefile  create mode 100644 samples/mei/TODO  create
> mode 100644 samples/mei/mei-amt-version.c
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile index
> 80b5bdc..3c2a207 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,2 +1,2 @@
>  subdir-y :=3D accounting auxdisplay blackfin \
> -	laptops misc-devices pcmcia timers watchdog
> +	laptops pcmcia timers watchdog
> diff --git a/Documentation/misc-devices/Makefile b/Documentation/misc-
> devices/Makefile
> deleted file mode 100644
> index e2b7aa4..0000000
> --- a/Documentation/misc-devices/Makefile
> +++ /dev/null
> @@ -1 +0,0 @@
> -subdir-y :=3D mei
> diff --git a/Documentation/misc-devices/mei/.gitignore
> b/Documentation/misc-devices/mei/.gitignore
> deleted file mode 100644
> index f356b81..0000000
> --- a/Documentation/misc-devices/mei/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -mei-amt-version
> diff --git a/Documentation/misc-devices/mei/Makefile
> b/Documentation/misc-devices/mei/Makefile
> deleted file mode 100644
> index d758047..0000000
> --- a/Documentation/misc-devices/mei/Makefile
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# List of programs to build
> -hostprogs-y :=3D mei-amt-version
> -HOSTCFLAGS_mei-amt-version.o +=3D -I$(objtree)/usr/include -# Tell kbuil=
d
> to always build the programs -always :=3D $(hostprogs-y) diff --git
> a/Documentation/misc-devices/mei/TODO b/Documentation/misc-
> devices/mei/TODO
> deleted file mode 100644
> index 6b3625d..0000000
> --- a/Documentation/misc-devices/mei/TODO
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -TODO:
> -	- Cleanup and split the timer function
> diff --git a/Documentation/misc-devices/mei/mei-amt-version.c
> b/Documentation/misc-devices/mei/mei-amt-version.c
> deleted file mode 100644
> index 57d0d87..0000000
> --- a/Documentation/misc-devices/mei/mei-amt-version.c
> +++ /dev/null
> @@ -1,479 +0,0 @@
> -
> /**********************************************************
> ********************
> - * Intel Management Engine Interface (Intel MEI) Linux driver
> - * Intel MEI Interface Header
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * Copyright(c) 2012 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110,
> - * USA
> - *
> - * The full GNU General Public License is included in this distribution
> - * in the file called LICENSE.GPL.
> - *
> - * Contact Information:
> - *	Intel Corporation.
> - *	linux-mei@linux.intel.com
> - *	http://www.intel.com
> - *
> - * BSD LICENSE
> - *
> - * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - *  * Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - *  * Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in
> - *    the documentation and/or other materials provided with the
> - *    distribution.
> - *  * Neither the name Intel Corporation nor the names of its
> - *    contributors may be used to endorse or promote products derived
> - *    from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
> AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> - *
> -
> **********************************************************
> *******************/
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <fcntl.h>
> -#include <sys/ioctl.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <stdint.h>
> -#include <stdbool.h>
> -#include <bits/wordsize.h>
> -#include <linux/mei.h>
> -
> -
> /**********************************************************
> *******************
> - * Intel Management Engine Interface
> -
> **********************************************************
> *******************/
> -
> -#define mei_msg(_me, fmt, ARGS...) do {         \
> -	if (_me->verbose)                       \
> -		fprintf(stderr, fmt, ##ARGS);	\
> -} while (0)
> -
> -#define mei_err(_me, fmt, ARGS...) do {         \
> -	fprintf(stderr, "Error: " fmt, ##ARGS); \
> -} while (0)
> -
> -struct mei {
> -	uuid_le guid;
> -	bool initialized;
> -	bool verbose;
> -	unsigned int buf_size;
> -	unsigned char prot_ver;
> -	int fd;
> -};
> -
> -static void mei_deinit(struct mei *cl)
> -{
> -	if (cl->fd !=3D -1)
> -		close(cl->fd);
> -	cl->fd =3D -1;
> -	cl->buf_size =3D 0;
> -	cl->prot_ver =3D 0;
> -	cl->initialized =3D false;
> -}
> -
> -static bool mei_init(struct mei *me, const uuid_le *guid,
> -		unsigned char req_protocol_version, bool verbose)
> -{
> -	int result;
> -	struct mei_client *cl;
> -	struct mei_connect_client_data data;
> -
> -	me->verbose =3D verbose;
> -
> -	me->fd =3D open("/dev/mei", O_RDWR);
> -	if (me->fd =3D=3D -1) {
> -		mei_err(me, "Cannot establish a handle to the Intel MEI
> driver\n");
> -		goto err;
> -	}
> -	memcpy(&me->guid, guid, sizeof(*guid));
> -	memset(&data, 0, sizeof(data));
> -	me->initialized =3D true;
> -
> -	memcpy(&data.in_client_uuid, &me->guid, sizeof(me->guid));
> -	result =3D ioctl(me->fd, IOCTL_MEI_CONNECT_CLIENT, &data);
> -	if (result) {
> -		mei_err(me, "IOCTL_MEI_CONNECT_CLIENT receive
> message. err=3D%d\n", result);
> -		goto err;
> -	}
> -	cl =3D &data.out_client_properties;
> -	mei_msg(me, "max_message_length %d\n", cl->max_msg_length);
> -	mei_msg(me, "protocol_version %d\n", cl->protocol_version);
> -
> -	if ((req_protocol_version > 0) &&
> -	     (cl->protocol_version !=3D req_protocol_version)) {
> -		mei_err(me, "Intel MEI protocol version not supported\n");
> -		goto err;
> -	}
> -
> -	me->buf_size =3D cl->max_msg_length;
> -	me->prot_ver =3D cl->protocol_version;
> -
> -	return true;
> -err:
> -	mei_deinit(me);
> -	return false;
> -}
> -
> -static ssize_t mei_recv_msg(struct mei *me, unsigned char *buffer,
> -			ssize_t len, unsigned long timeout)
> -{
> -	ssize_t rc;
> -
> -	mei_msg(me, "call read length =3D %zd\n", len);
> -
> -	rc =3D read(me->fd, buffer, len);
> -	if (rc < 0) {
> -		mei_err(me, "read failed with status %zd %s\n",
> -				rc, strerror(errno));
> -		mei_deinit(me);
> -	} else {
> -		mei_msg(me, "read succeeded with result %zd\n", rc);
> -	}
> -	return rc;
> -}
> -
> -static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
> -			ssize_t len, unsigned long timeout)
> -{
> -	struct timeval tv;
> -	ssize_t written;
> -	ssize_t rc;
> -	fd_set set;
> -
> -	tv.tv_sec =3D timeout / 1000;
> -	tv.tv_usec =3D (timeout % 1000) * 1000000;
> -
> -	mei_msg(me, "call write length =3D %zd\n", len);
> -
> -	written =3D write(me->fd, buffer, len);
> -	if (written < 0) {
> -		rc =3D -errno;
> -		mei_err(me, "write failed with status %zd %s\n",
> -			written, strerror(errno));
> -		goto out;
> -	}
> -
> -	FD_ZERO(&set);
> -	FD_SET(me->fd, &set);
> -	rc =3D select(me->fd + 1 , &set, NULL, NULL, &tv);
> -	if (rc > 0 && FD_ISSET(me->fd, &set)) {
> -		mei_msg(me, "write success\n");
> -	} else if (rc =3D=3D 0) {
> -		mei_err(me, "write failed on timeout with status\n");
> -		goto out;
> -	} else { /* rc < 0 */
> -		mei_err(me, "write failed on select with status %zd\n", rc);
> -		goto out;
> -	}
> -
> -	rc =3D written;
> -out:
> -	if (rc < 0)
> -		mei_deinit(me);
> -
> -	return rc;
> -}
> -
> -
> /**********************************************************
> *****************
> - * Intel Advanced Management Technology ME Client
> -
> **********************************************************
> *****************/
> -
> -#define AMT_MAJOR_VERSION 1
> -#define AMT_MINOR_VERSION 1
> -
> -#define AMT_STATUS_SUCCESS                0x0
> -#define AMT_STATUS_INTERNAL_ERROR         0x1
> -#define AMT_STATUS_NOT_READY              0x2
> -#define AMT_STATUS_INVALID_AMT_MODE       0x3
> -#define AMT_STATUS_INVALID_MESSAGE_LENGTH 0x4
> -
> -#define AMT_STATUS_HOST_IF_EMPTY_RESPONSE  0x4000
> -#define AMT_STATUS_SDK_RESOURCES      0x1004
> -
> -
> -#define AMT_BIOS_VERSION_LEN   65
> -#define AMT_VERSIONS_NUMBER    50
> -#define AMT_UNICODE_STRING_LEN 20
> -
> -struct amt_unicode_string {
> -	uint16_t length;
> -	char string[AMT_UNICODE_STRING_LEN];
> -} __attribute__((packed));
> -
> -struct amt_version_type {
> -	struct amt_unicode_string description;
> -	struct amt_unicode_string version;
> -} __attribute__((packed));
> -
> -struct amt_version {
> -	uint8_t major;
> -	uint8_t minor;
> -} __attribute__((packed));
> -
> -struct amt_code_versions {
> -	uint8_t bios[AMT_BIOS_VERSION_LEN];
> -	uint32_t count;
> -	struct amt_version_type versions[AMT_VERSIONS_NUMBER];
> -} __attribute__((packed));
> -
> -
> /**********************************************************
> *****************
> - * Intel Advanced Management Technology Host Interface
> -
> **********************************************************
> *****************/
> -
> -struct amt_host_if_msg_header {
> -	struct amt_version version;
> -	uint16_t _reserved;
> -	uint32_t command;
> -	uint32_t length;
> -} __attribute__((packed));
> -
> -struct amt_host_if_resp_header {
> -	struct amt_host_if_msg_header header;
> -	uint32_t status;
> -	unsigned char data[0];
> -} __attribute__((packed));
> -
> -const uuid_le MEI_IAMTHIF =3D UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \
> -				0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81, 0x4c);
> -
> -#define AMT_HOST_IF_CODE_VERSIONS_REQUEST  0x0400001A -#define
> AMT_HOST_IF_CODE_VERSIONS_RESPONSE 0x0480001A
> -
> -const struct amt_host_if_msg_header CODE_VERSION_REQ =3D {
> -	.version =3D {AMT_MAJOR_VERSION, AMT_MINOR_VERSION},
> -	._reserved =3D 0,
> -	.command =3D AMT_HOST_IF_CODE_VERSIONS_REQUEST,
> -	.length =3D 0
> -};
> -
> -
> -struct amt_host_if {
> -	struct mei mei_cl;
> -	unsigned long send_timeout;
> -	bool initialized;
> -};
> -
> -
> -static bool amt_host_if_init(struct amt_host_if *acmd,
> -		      unsigned long send_timeout, bool verbose)
> -{
> -	acmd->send_timeout =3D (send_timeout) ? send_timeout : 20000;
> -	acmd->initialized =3D mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0,
> verbose);
> -	return acmd->initialized;
> -}
> -
> -static void amt_host_if_deinit(struct amt_host_if *acmd) -{
> -	mei_deinit(&acmd->mei_cl);
> -	acmd->initialized =3D false;
> -}
> -
> -static uint32_t amt_verify_code_versions(const struct
> amt_host_if_resp_header *resp) -{
> -	uint32_t status =3D AMT_STATUS_SUCCESS;
> -	struct amt_code_versions *code_ver;
> -	size_t code_ver_len;
> -	uint32_t ver_type_cnt;
> -	uint32_t len;
> -	uint32_t i;
> -
> -	code_ver =3D (struct amt_code_versions *)resp->data;
> -	/* length - sizeof(status) */
> -	code_ver_len =3D resp->header.length - sizeof(uint32_t);
> -	ver_type_cnt =3D code_ver_len -
> -			sizeof(code_ver->bios) -
> -			sizeof(code_ver->count);
> -	if (code_ver->count !=3D ver_type_cnt / sizeof(struct
> amt_version_type)) {
> -		status =3D AMT_STATUS_INTERNAL_ERROR;
> -		goto out;
> -	}
> -
> -	for (i =3D 0; i < code_ver->count; i++) {
> -		len =3D code_ver->versions[i].description.length;
> -
> -		if (len > AMT_UNICODE_STRING_LEN) {
> -			status =3D AMT_STATUS_INTERNAL_ERROR;
> -			goto out;
> -		}
> -
> -		len =3D code_ver->versions[i].version.length;
> -		if (code_ver->versions[i].version.string[len] !=3D '\0' ||
> -		    len !=3D strlen(code_ver->versions[i].version.string)) {
> -			status =3D AMT_STATUS_INTERNAL_ERROR;
> -			goto out;
> -		}
> -	}
> -out:
> -	return status;
> -}
> -
> -static uint32_t amt_verify_response_header(uint32_t command,
> -				const struct amt_host_if_msg_header
> *resp_hdr,
> -				uint32_t response_size)
> -{
> -	if (response_size < sizeof(struct amt_host_if_resp_header)) {
> -		return AMT_STATUS_INTERNAL_ERROR;
> -	} else if (response_size !=3D (resp_hdr->length +
> -				sizeof(struct amt_host_if_msg_header))) {
> -		return AMT_STATUS_INTERNAL_ERROR;
> -	} else if (resp_hdr->command !=3D command) {
> -		return AMT_STATUS_INTERNAL_ERROR;
> -	} else if (resp_hdr->_reserved !=3D 0) {
> -		return AMT_STATUS_INTERNAL_ERROR;
> -	} else if (resp_hdr->version.major !=3D AMT_MAJOR_VERSION ||
> -		   resp_hdr->version.minor < AMT_MINOR_VERSION) {
> -		return AMT_STATUS_INTERNAL_ERROR;
> -	}
> -	return AMT_STATUS_SUCCESS;
> -}
> -
> -static uint32_t amt_host_if_call(struct amt_host_if *acmd,
> -			const unsigned char *command, ssize_t
> command_sz,
> -			uint8_t **read_buf, uint32_t rcmd,
> -			unsigned int expected_sz)
> -{
> -	uint32_t in_buf_sz;
> -	uint32_t out_buf_sz;
> -	ssize_t written;
> -	uint32_t status;
> -	struct amt_host_if_resp_header *msg_hdr;
> -
> -	in_buf_sz =3D acmd->mei_cl.buf_size;
> -	*read_buf =3D (uint8_t *)malloc(sizeof(uint8_t) * in_buf_sz);
> -	if (*read_buf =3D=3D NULL)
> -		return AMT_STATUS_SDK_RESOURCES;
> -	memset(*read_buf, 0, in_buf_sz);
> -	msg_hdr =3D (struct amt_host_if_resp_header *)*read_buf;
> -
> -	written =3D mei_send_msg(&acmd->mei_cl,
> -				command, command_sz, acmd-
> >send_timeout);
> -	if (written !=3D command_sz)
> -		return AMT_STATUS_INTERNAL_ERROR;
> -
> -	out_buf_sz =3D mei_recv_msg(&acmd->mei_cl, *read_buf, in_buf_sz,
> 2000);
> -	if (out_buf_sz <=3D 0)
> -		return AMT_STATUS_HOST_IF_EMPTY_RESPONSE;
> -
> -	status =3D msg_hdr->status;
> -	if (status !=3D AMT_STATUS_SUCCESS)
> -		return status;
> -
> -	status =3D amt_verify_response_header(rcmd,
> -				&msg_hdr->header, out_buf_sz);
> -	if (status !=3D AMT_STATUS_SUCCESS)
> -		return status;
> -
> -	if (expected_sz && expected_sz !=3D out_buf_sz)
> -		return AMT_STATUS_INTERNAL_ERROR;
> -
> -	return AMT_STATUS_SUCCESS;
> -}
> -
> -
> -static uint32_t amt_get_code_versions(struct amt_host_if *cmd,
> -			       struct amt_code_versions *versions)
> -{
> -	struct amt_host_if_resp_header *response =3D NULL;
> -	uint32_t status;
> -
> -	status =3D amt_host_if_call(cmd,
> -			(const unsigned char *)&CODE_VERSION_REQ,
> -			sizeof(CODE_VERSION_REQ),
> -			(uint8_t **)&response,
> -			AMT_HOST_IF_CODE_VERSIONS_RESPONSE, 0);
> -
> -	if (status !=3D AMT_STATUS_SUCCESS)
> -		goto out;
> -
> -	status =3D amt_verify_code_versions(response);
> -	if (status !=3D AMT_STATUS_SUCCESS)
> -		goto out;
> -
> -	memcpy(versions, response->data, sizeof(struct
> amt_code_versions));
> -out:
> -	if (response !=3D NULL)
> -		free(response);
> -
> -	return status;
> -}
> -
> -/************************** end of amt_host_if_command
> ***********************/ -int main(int argc, char **argv) -{
> -	struct amt_code_versions ver;
> -	struct amt_host_if acmd;
> -	unsigned int i;
> -	uint32_t status;
> -	int ret;
> -	bool verbose;
> -
> -	verbose =3D (argc > 1 && strcmp(argv[1], "-v") =3D=3D 0);
> -
> -	if (!amt_host_if_init(&acmd, 5000, verbose)) {
> -		ret =3D 1;
> -		goto out;
> -	}
> -
> -	status =3D amt_get_code_versions(&acmd, &ver);
> -
> -	amt_host_if_deinit(&acmd);
> -
> -	switch (status) {
> -	case AMT_STATUS_HOST_IF_EMPTY_RESPONSE:
> -		printf("Intel AMT: DISABLED\n");
> -		ret =3D 0;
> -		break;
> -	case AMT_STATUS_SUCCESS:
> -		printf("Intel AMT: ENABLED\n");
> -		for (i =3D 0; i < ver.count; i++) {
> -			printf("%s:\t%s\n", ver.versions[i].description.string,
> -				ver.versions[i].version.string);
> -		}
> -		ret =3D 0;
> -		break;
> -	default:
> -		printf("An error has occurred\n");
> -		ret =3D 1;
> -		break;
> -	}
> -
> -out:
> -	return ret;
> -}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5e1270..afd3577 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6261,6 +6261,7 @@ F:	include/linux/mei_cl_bus.h
>  F:	drivers/misc/mei/*
>  F:	drivers/watchdog/mei_wdt.c
>  F:	Documentation/misc-devices/mei/*
> +F:	samples/mei/*
>=20
>  INTEL MIC DRIVERS (mic)
>  M:	Sudeep Dutt <sudeep.dutt@intel.com>
> diff --git a/samples/mei/.gitignore b/samples/mei/.gitignore new file mod=
e
> 100644 index 0000000..f356b81
> --- /dev/null
> +++ b/samples/mei/.gitignore
> @@ -0,0 +1 @@
> +mei-amt-version
> diff --git a/samples/mei/Makefile b/samples/mei/Makefile new file mode
> 100644 index 0000000..7aac216
> --- /dev/null
> +++ b/samples/mei/Makefile
> @@ -0,0 +1,9 @@
> +CC :=3D $(CROSS_COMPILE)gcc
> +CFLAGS :=3D -I../../usr/include
> +
> +PROGS :=3D mei-amt-version
> +
> +all: $(PROGS)
> +
> +clean:
> +	rm -fr $(PROGS)
> diff --git a/samples/mei/TODO b/samples/mei/TODO new file mode 100644
> index 0000000..6b3625d
> --- /dev/null
> +++ b/samples/mei/TODO
> @@ -0,0 +1,2 @@
> +TODO:
> +	- Cleanup and split the timer function
> diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-
> version.c new file mode 100644 index 0000000..57d0d87
> --- /dev/null
> +++ b/samples/mei/mei-amt-version.c
> @@ -0,0 +1,479 @@
> +/*********************************************************
> *************
> +********
> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + * Intel MEI Interface Header
> + *
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.
> + *
> + * GPL LICENSE SUMMARY
> + *
> + * Copyright(c) 2012 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110,
> + * USA
> + *
> + * The full GNU General Public License is included in this distribution
> + * in the file called LICENSE.GPL.
> + *
> + * Contact Information:
> + *	Intel Corporation.
> + *	linux-mei@linux.intel.com
> + *	http://www.intel.com
> + *
> + * BSD LICENSE
> + *
> + * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *  * Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + *  * Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in
> + *    the documentation and/or other materials provided with the
> + *    distribution.
> + *  * Neither the name Intel Corporation nor the names of its
> + *    contributors may be used to endorse or promote products derived
> + *    from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS
> +FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> +INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF
> +USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
> AND ON
> +ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE
> +USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> + *
> +
> +*********************************************************
> **************
> +******/
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <bits/wordsize.h>
> +#include <linux/mei.h>
> +
> +/*********************************************************
> *************
> +*******
> + * Intel Management Engine Interface
> +
> +*********************************************************
> **************
> +******/
> +
> +#define mei_msg(_me, fmt, ARGS...) do {         \
> +	if (_me->verbose)                       \
> +		fprintf(stderr, fmt, ##ARGS);	\
> +} while (0)
> +
> +#define mei_err(_me, fmt, ARGS...) do {         \
> +	fprintf(stderr, "Error: " fmt, ##ARGS); \ } while (0)
> +
> +struct mei {
> +	uuid_le guid;
> +	bool initialized;
> +	bool verbose;
> +	unsigned int buf_size;
> +	unsigned char prot_ver;
> +	int fd;
> +};
> +
> +static void mei_deinit(struct mei *cl)
> +{
> +	if (cl->fd !=3D -1)
> +		close(cl->fd);
> +	cl->fd =3D -1;
> +	cl->buf_size =3D 0;
> +	cl->prot_ver =3D 0;
> +	cl->initialized =3D false;
> +}
> +
> +static bool mei_init(struct mei *me, const uuid_le *guid,
> +		unsigned char req_protocol_version, bool verbose) {
> +	int result;
> +	struct mei_client *cl;
> +	struct mei_connect_client_data data;
> +
> +	me->verbose =3D verbose;
> +
> +	me->fd =3D open("/dev/mei", O_RDWR);
> +	if (me->fd =3D=3D -1) {
> +		mei_err(me, "Cannot establish a handle to the Intel MEI
> driver\n");
> +		goto err;
> +	}
> +	memcpy(&me->guid, guid, sizeof(*guid));
> +	memset(&data, 0, sizeof(data));
> +	me->initialized =3D true;
> +
> +	memcpy(&data.in_client_uuid, &me->guid, sizeof(me->guid));
> +	result =3D ioctl(me->fd, IOCTL_MEI_CONNECT_CLIENT, &data);
> +	if (result) {
> +		mei_err(me, "IOCTL_MEI_CONNECT_CLIENT receive
> message. err=3D%d\n", result);
> +		goto err;
> +	}
> +	cl =3D &data.out_client_properties;
> +	mei_msg(me, "max_message_length %d\n", cl->max_msg_length);
> +	mei_msg(me, "protocol_version %d\n", cl->protocol_version);
> +
> +	if ((req_protocol_version > 0) &&
> +	     (cl->protocol_version !=3D req_protocol_version)) {
> +		mei_err(me, "Intel MEI protocol version not supported\n");
> +		goto err;
> +	}
> +
> +	me->buf_size =3D cl->max_msg_length;
> +	me->prot_ver =3D cl->protocol_version;
> +
> +	return true;
> +err:
> +	mei_deinit(me);
> +	return false;
> +}
> +
> +static ssize_t mei_recv_msg(struct mei *me, unsigned char *buffer,
> +			ssize_t len, unsigned long timeout)
> +{
> +	ssize_t rc;
> +
> +	mei_msg(me, "call read length =3D %zd\n", len);
> +
> +	rc =3D read(me->fd, buffer, len);
> +	if (rc < 0) {
> +		mei_err(me, "read failed with status %zd %s\n",
> +				rc, strerror(errno));
> +		mei_deinit(me);
> +	} else {
> +		mei_msg(me, "read succeeded with result %zd\n", rc);
> +	}
> +	return rc;
> +}
> +
> +static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
> +			ssize_t len, unsigned long timeout)
> +{
> +	struct timeval tv;
> +	ssize_t written;
> +	ssize_t rc;
> +	fd_set set;
> +
> +	tv.tv_sec =3D timeout / 1000;
> +	tv.tv_usec =3D (timeout % 1000) * 1000000;
> +
> +	mei_msg(me, "call write length =3D %zd\n", len);
> +
> +	written =3D write(me->fd, buffer, len);
> +	if (written < 0) {
> +		rc =3D -errno;
> +		mei_err(me, "write failed with status %zd %s\n",
> +			written, strerror(errno));
> +		goto out;
> +	}
> +
> +	FD_ZERO(&set);
> +	FD_SET(me->fd, &set);
> +	rc =3D select(me->fd + 1 , &set, NULL, NULL, &tv);
> +	if (rc > 0 && FD_ISSET(me->fd, &set)) {
> +		mei_msg(me, "write success\n");
> +	} else if (rc =3D=3D 0) {
> +		mei_err(me, "write failed on timeout with status\n");
> +		goto out;
> +	} else { /* rc < 0 */
> +		mei_err(me, "write failed on select with status %zd\n", rc);
> +		goto out;
> +	}
> +
> +	rc =3D written;
> +out:
> +	if (rc < 0)
> +		mei_deinit(me);
> +
> +	return rc;
> +}
> +
> +/*********************************************************
> *************
> +*****
> + * Intel Advanced Management Technology ME Client
> +*********************************************************
> **************
> +****/
> +
> +#define AMT_MAJOR_VERSION 1
> +#define AMT_MINOR_VERSION 1
> +
> +#define AMT_STATUS_SUCCESS                0x0
> +#define AMT_STATUS_INTERNAL_ERROR         0x1
> +#define AMT_STATUS_NOT_READY              0x2
> +#define AMT_STATUS_INVALID_AMT_MODE       0x3
> +#define AMT_STATUS_INVALID_MESSAGE_LENGTH 0x4
> +
> +#define AMT_STATUS_HOST_IF_EMPTY_RESPONSE  0x4000
> +#define AMT_STATUS_SDK_RESOURCES      0x1004
> +
> +
> +#define AMT_BIOS_VERSION_LEN   65
> +#define AMT_VERSIONS_NUMBER    50
> +#define AMT_UNICODE_STRING_LEN 20
> +
> +struct amt_unicode_string {
> +	uint16_t length;
> +	char string[AMT_UNICODE_STRING_LEN];
> +} __attribute__((packed));
> +
> +struct amt_version_type {
> +	struct amt_unicode_string description;
> +	struct amt_unicode_string version;
> +} __attribute__((packed));
> +
> +struct amt_version {
> +	uint8_t major;
> +	uint8_t minor;
> +} __attribute__((packed));
> +
> +struct amt_code_versions {
> +	uint8_t bios[AMT_BIOS_VERSION_LEN];
> +	uint32_t count;
> +	struct amt_version_type versions[AMT_VERSIONS_NUMBER]; }
> +__attribute__((packed));
> +
> +/*********************************************************
> *************
> +*****
> + * Intel Advanced Management Technology Host Interface
> +*********************************************************
> **************
> +****/
> +
> +struct amt_host_if_msg_header {
> +	struct amt_version version;
> +	uint16_t _reserved;
> +	uint32_t command;
> +	uint32_t length;
> +} __attribute__((packed));
> +
> +struct amt_host_if_resp_header {
> +	struct amt_host_if_msg_header header;
> +	uint32_t status;
> +	unsigned char data[0];
> +} __attribute__((packed));
> +
> +const uuid_le MEI_IAMTHIF =3D UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \
> +				0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81, 0x4c);
> +
> +#define AMT_HOST_IF_CODE_VERSIONS_REQUEST  0x0400001A #define
> +AMT_HOST_IF_CODE_VERSIONS_RESPONSE 0x0480001A
> +
> +const struct amt_host_if_msg_header CODE_VERSION_REQ =3D {
> +	.version =3D {AMT_MAJOR_VERSION, AMT_MINOR_VERSION},
> +	._reserved =3D 0,
> +	.command =3D AMT_HOST_IF_CODE_VERSIONS_REQUEST,
> +	.length =3D 0
> +};
> +
> +
> +struct amt_host_if {
> +	struct mei mei_cl;
> +	unsigned long send_timeout;
> +	bool initialized;
> +};
> +
> +
> +static bool amt_host_if_init(struct amt_host_if *acmd,
> +		      unsigned long send_timeout, bool verbose) {
> +	acmd->send_timeout =3D (send_timeout) ? send_timeout : 20000;
> +	acmd->initialized =3D mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0,
> verbose);
> +	return acmd->initialized;
> +}
> +
> +static void amt_host_if_deinit(struct amt_host_if *acmd) {
> +	mei_deinit(&acmd->mei_cl);
> +	acmd->initialized =3D false;
> +}
> +
> +static uint32_t amt_verify_code_versions(const struct
> +amt_host_if_resp_header *resp) {
> +	uint32_t status =3D AMT_STATUS_SUCCESS;
> +	struct amt_code_versions *code_ver;
> +	size_t code_ver_len;
> +	uint32_t ver_type_cnt;
> +	uint32_t len;
> +	uint32_t i;
> +
> +	code_ver =3D (struct amt_code_versions *)resp->data;
> +	/* length - sizeof(status) */
> +	code_ver_len =3D resp->header.length - sizeof(uint32_t);
> +	ver_type_cnt =3D code_ver_len -
> +			sizeof(code_ver->bios) -
> +			sizeof(code_ver->count);
> +	if (code_ver->count !=3D ver_type_cnt / sizeof(struct
> amt_version_type)) {
> +		status =3D AMT_STATUS_INTERNAL_ERROR;
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < code_ver->count; i++) {
> +		len =3D code_ver->versions[i].description.length;
> +
> +		if (len > AMT_UNICODE_STRING_LEN) {
> +			status =3D AMT_STATUS_INTERNAL_ERROR;
> +			goto out;
> +		}
> +
> +		len =3D code_ver->versions[i].version.length;
> +		if (code_ver->versions[i].version.string[len] !=3D '\0' ||
> +		    len !=3D strlen(code_ver->versions[i].version.string)) {
> +			status =3D AMT_STATUS_INTERNAL_ERROR;
> +			goto out;
> +		}
> +	}
> +out:
> +	return status;
> +}
> +
> +static uint32_t amt_verify_response_header(uint32_t command,
> +				const struct amt_host_if_msg_header
> *resp_hdr,
> +				uint32_t response_size)
> +{
> +	if (response_size < sizeof(struct amt_host_if_resp_header)) {
> +		return AMT_STATUS_INTERNAL_ERROR;
> +	} else if (response_size !=3D (resp_hdr->length +
> +				sizeof(struct amt_host_if_msg_header))) {
> +		return AMT_STATUS_INTERNAL_ERROR;
> +	} else if (resp_hdr->command !=3D command) {
> +		return AMT_STATUS_INTERNAL_ERROR;
> +	} else if (resp_hdr->_reserved !=3D 0) {
> +		return AMT_STATUS_INTERNAL_ERROR;
> +	} else if (resp_hdr->version.major !=3D AMT_MAJOR_VERSION ||
> +		   resp_hdr->version.minor < AMT_MINOR_VERSION) {
> +		return AMT_STATUS_INTERNAL_ERROR;
> +	}
> +	return AMT_STATUS_SUCCESS;
> +}
> +
> +static uint32_t amt_host_if_call(struct amt_host_if *acmd,
> +			const unsigned char *command, ssize_t
> command_sz,
> +			uint8_t **read_buf, uint32_t rcmd,
> +			unsigned int expected_sz)
> +{
> +	uint32_t in_buf_sz;
> +	uint32_t out_buf_sz;
> +	ssize_t written;
> +	uint32_t status;
> +	struct amt_host_if_resp_header *msg_hdr;
> +
> +	in_buf_sz =3D acmd->mei_cl.buf_size;
> +	*read_buf =3D (uint8_t *)malloc(sizeof(uint8_t) * in_buf_sz);
> +	if (*read_buf =3D=3D NULL)
> +		return AMT_STATUS_SDK_RESOURCES;
> +	memset(*read_buf, 0, in_buf_sz);
> +	msg_hdr =3D (struct amt_host_if_resp_header *)*read_buf;
> +
> +	written =3D mei_send_msg(&acmd->mei_cl,
> +				command, command_sz, acmd-
> >send_timeout);
> +	if (written !=3D command_sz)
> +		return AMT_STATUS_INTERNAL_ERROR;
> +
> +	out_buf_sz =3D mei_recv_msg(&acmd->mei_cl, *read_buf, in_buf_sz,
> 2000);
> +	if (out_buf_sz <=3D 0)
> +		return AMT_STATUS_HOST_IF_EMPTY_RESPONSE;
> +
> +	status =3D msg_hdr->status;
> +	if (status !=3D AMT_STATUS_SUCCESS)
> +		return status;
> +
> +	status =3D amt_verify_response_header(rcmd,
> +				&msg_hdr->header, out_buf_sz);
> +	if (status !=3D AMT_STATUS_SUCCESS)
> +		return status;
> +
> +	if (expected_sz && expected_sz !=3D out_buf_sz)
> +		return AMT_STATUS_INTERNAL_ERROR;
> +
> +	return AMT_STATUS_SUCCESS;
> +}
> +
> +
> +static uint32_t amt_get_code_versions(struct amt_host_if *cmd,
> +			       struct amt_code_versions *versions) {
> +	struct amt_host_if_resp_header *response =3D NULL;
> +	uint32_t status;
> +
> +	status =3D amt_host_if_call(cmd,
> +			(const unsigned char *)&CODE_VERSION_REQ,
> +			sizeof(CODE_VERSION_REQ),
> +			(uint8_t **)&response,
> +			AMT_HOST_IF_CODE_VERSIONS_RESPONSE, 0);
> +
> +	if (status !=3D AMT_STATUS_SUCCESS)
> +		goto out;
> +
> +	status =3D amt_verify_code_versions(response);
> +	if (status !=3D AMT_STATUS_SUCCESS)
> +		goto out;
> +
> +	memcpy(versions, response->data, sizeof(struct
> amt_code_versions));
> +out:
> +	if (response !=3D NULL)
> +		free(response);
> +
> +	return status;
> +}
> +
> +/************************** end of amt_host_if_command
> +***********************/ int main(int argc, char **argv) {
> +	struct amt_code_versions ver;
> +	struct amt_host_if acmd;
> +	unsigned int i;
> +	uint32_t status;
> +	int ret;
> +	bool verbose;
> +
> +	verbose =3D (argc > 1 && strcmp(argv[1], "-v") =3D=3D 0);
> +
> +	if (!amt_host_if_init(&acmd, 5000, verbose)) {
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	status =3D amt_get_code_versions(&acmd, &ver);
> +
> +	amt_host_if_deinit(&acmd);
> +
> +	switch (status) {
> +	case AMT_STATUS_HOST_IF_EMPTY_RESPONSE:
> +		printf("Intel AMT: DISABLED\n");
> +		ret =3D 0;
> +		break;
> +	case AMT_STATUS_SUCCESS:
> +		printf("Intel AMT: ENABLED\n");
> +		for (i =3D 0; i < ver.count; i++) {
> +			printf("%s:\t%s\n", ver.versions[i].description.string,
> +				ver.versions[i].version.string);
> +		}
> +		ret =3D 0;
> +		break;
> +	default:
> +		printf("An error has occurred\n");
> +		ret =3D 1;
> +		break;
> +	}
> +
> +out:
> +	return ret;
> +}
> --
> 2.7.4

